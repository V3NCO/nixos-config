console.log("Starting SyncPronote application...")

// Importer les libs
var { startPresenceInterval, createSessionHandle, loginToken, AccountKind, timetableFromIntervals, parseTimetable } = require("pawnote")
const path = require("path")
const { CronJob } = require("cron")
const manageSecrets = require("./utils/manage-secrets")
const classnameParser = require("./utils/classnames")
const sendNtfy = require("./utils/ntfy")
const customHours = require("./utils/custom-hours")
const { unstrikethrough, strikethrough } = require("./utils/strikethrough")
const icalendar = require("./utils/icalendar")

var secrets = manageSecrets.parse(path.join(__dirname, ".config", "secrets.json"))

// Convertir une date en un string human-readable et relatif
function dateToString(date) {
    if (date.toDateString() == new Date().toDateString()) return "d'aujourd'hui"
    if (date.toDateString() == new Date(new Date().getTime() + 86400000).toDateString()) return "de demain"
    if (date.toDateString() == new Date(new Date().getTime() - 86400000).toDateString()) return "d'hier"
    return `du ${date.toLocaleDateString("fr-FR", { day: "numeric", month: "long" })}`
}

// Enlever les crochets au début et à la fin d'un string
function removeBrackets(string) {
    if (string.startsWith("[")) string = string.substring(1)
    if (string.endsWith("]")) string = string.substring(0, string.length - 1)
    return string
}

function isClassCanceled(pronoteClass) {
    const isMarkedOptional = pronoteClass?.exempted?.V?.L?.includes("non obligatoire")
    return Boolean(pronoteClass?.canceled || pronoteClass?.estAnnule || isMarkedOptional)
}

// Générer un identifieur unique en fonction des éléments de chaque cours
function generateUniqueIdCourse(type, start, end, name) {
    var name = name.toLowerCase().replace(/[^a-z0-9]/g, "")
    name = unstrikethrough(name.replace(/̶/g, ""))
    return `${type}-${start.getTime()}-${end.getTime()}-${name}`
}

// Transformer un array de différents éléments de l'EDT en un string
function arrayToStringMasculin(array) {
    if (!array?.length) return "aucun"
    return array?.join(", ")
}

// Déterminer le début et la fin de la semaine qu'on va récupérer
function getWeekBounds() {
    const today = new Date()
    const todayOfWeek = today.getDay()
    const start = new Date(today)

    if (todayOfWeek == 0) start.setDate(today.getDate())
    else start.setDate(today.getDate() - todayOfWeek)
    start.setHours(0, 0, 0, 0)

    const end = new Date(start)
    end.setDate(start.getDate() + (todayOfWeek == 0 ? 6 : 5) + (7 * 3))
    end.setHours(23, 59, 59, 999)

    return { start, end }
}

// Fonction principale
async function main() {
    console.log("Initializing SyncPronote...");
    const icsFilePath = path.join(__dirname, ".config", "calendar.ics");
    console.log(`iCalendar file path set to: ${icsFilePath}`);

    var pronoteHandler
    var pronoteClient
    var pronoteToken = secrets.PRONOTE_TOKEN

    async function pronoteLogin() {
        const pronoteDetails = {
            url: secrets.PRONOTE_ROOT_URL,
            kind: secrets.PRONOTE_ACCOUNT_KIND == "6" ? AccountKind.STUDENT : secrets.PRONOTE_ACCOUNT_KIND,
            username: secrets.PRONOTE_USERNAME,
            token: pronoteToken,
            deviceUUID: secrets.PRONOTE_DEVICE_UUID,
        }

        console.log("Creating Pronote session handle...");
        pronoteHandler = createSessionHandle();
        pronoteClient = await loginToken(pronoteHandler, pronoteDetails).catch(async e => {
            console.error("Failed to authenticate with Pronote:", e);
            await new Promise(resolve => setTimeout(resolve, 45000))
            process.exit(1);
        })
        console.log("Successfully authenticated with Pronote. Starting presence interval...");
        startPresenceInterval(pronoteHandler);

        pronoteToken = pronoteClient.token
        secrets.PRONOTE_TOKEN = pronoteClient.token
        console.log("Saving updated Pronote token to secrets.json...");
        manageSecrets.save(path.join(__dirname, ".config", "secrets.json"), secrets);
    }
    await pronoteLogin()

    async function getPronoteSchedule() {
        console.log("Fetching schedule from Pronote...");
        var calendar = [];
        var weekBounds = getWeekBounds()

        var timetable
        try {
            timetable = await timetableFromIntervals(pronoteHandler, weekBounds.start, weekBounds.end)
        } catch (e) {
            console.error("Impossible de récupérer l'emploi du temps :", e)
            if (e.message.includes("The page has expired")) await pronoteLogin()
        }
        if (!timetable) return calendar
        parseTimetable(pronoteHandler, timetable, {
            withSuperposedCanceledClasses: false,
            withCanceledClasses: true,
            withPlannedClasses: true,
        })

        timetable.classes.forEach(currentClass => {
            if (currentClass.is == "activity") {
                calendar.push({
                    type: "activity",
                    start: currentClass.startDate,
                    end: currentClass.endDate,
                    name: classnameParser(currentClass.title ?? "???"),
                    teachers: currentClass.attendants ?? [],
                    classrooms: [],
                    groups: [],
                    status: currentClass.status,
                    id: generateUniqueIdCourse("activity", currentClass.startDate, currentClass.endDate, currentClass.title),
                    canceled: isClassCanceled(currentClass)
                })
            } else if (currentClass.is == "lesson") {
                calendar.push({
                    type: "lesson",
                    start: currentClass.startDate,
                    end: currentClass.endDate,
                    name: classnameParser(currentClass.subject?.name ?? "???"),
                    teachers: currentClass.teacherNames ?? [],
                    classrooms: currentClass.classrooms ?? [],
                    groups: currentClass.groupNames ?? [],
                    status: currentClass.status,
                    id: generateUniqueIdCourse("lesson", currentClass.startDate, currentClass.endDate, currentClass.subject?.name),
                    canceled: isClassCanceled(currentClass)
                })
            }
        })

        return calendar
    }

    async function overwriteICSEvents(newEvents) {
        try {
            console.log("Overwriting iCalendar events with new events...");
            icalendar.overwriteICSEvents(icsFilePath, newEvents);
            console.log("iCalendar events successfully overwritten.");
        } catch (e) {
            console.error("Erreur lors de l'écrasement des événements dans le fichier iCalendar :", e)
        }
    }

    const job = new CronJob(
        "*/30 6-22 * * *", // Every 30 minutes
        async function () {
            console.log("Cron job triggered at:", new Date().toISOString());
            console.log("Starting periodic check for schedule updates...");
            var pronoteCalendar = await getPronoteSchedule();
            console.log("Schedule fetched from Pronote. Processing events...");

            const activeEvents = pronoteCalendar.filter(event => !event.canceled);
            console.log(`Filtered out ${pronoteCalendar.length - activeEvents.length} canceled events.`);

            activeEvents.forEach(event => {
                event.start = customHours.correctTime(event.start, "start");
                event.end = customHours.correctTime(event.end, "end");
            });

            console.log("Updating iCalendar file with the latest schedule...");
            await overwriteICSEvents(activeEvents);
            console.log("iCalendar file updated successfully.");

            try {
                console.log("Uploading iCalendar file to Radicale...");
                await icalendar.uploadToRadicale(activeEvents, icsFilePath);
                console.log("iCalendar file uploaded successfully to Radicale.");
            } catch (error) {
                console.error("Error while uploading the iCalendar file to the Radicale server:", error);
            }
        },
        null,
        true // Start the job immediately
    );

    // Explicitly start the cron job
    job.start();
}
main()
