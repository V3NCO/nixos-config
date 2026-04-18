const icalGeneratorImport = require('ical-generator');
const icalGenerator = typeof icalGeneratorImport === 'function'
    ? icalGeneratorImport
    : icalGeneratorImport.default || icalGeneratorImport;

const nodeIcal = require('node-ical');
const fs = require('fs');
const path = require('path');

const manageSecrets = require('./manage-secrets');

const secretsPath = path.join(__dirname, '..', '.config', 'secrets.json');
const secrets = manageSecrets.parse(secretsPath);

// -----------------------------------------------------------------------------
// Generic helpers
// -----------------------------------------------------------------------------
function ensureDirectoryExists(filePath) {
    const dir = path.dirname(filePath);
    if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true });
    }
}

function decodeXml(value = '') {
    return value
        .replace(/&lt;/g, '<')
        .replace(/&gt;/g, '>')
        .replace(/&quot;/g, '"')
        .replace(/&apos;/g, '\'')
        .replace(/&amp;/g, '&');
}

function mapEventToICalFields(event) {
    const startDate = new Date(event.start);
    const endDate = new Date(event.end);
    const summary = event.summary || event.name || event.title || 'Pronote event';

    const locationFromEvent = event.location
        || (Array.isArray(event.classrooms) && event.classrooms.length ? event.classrooms.join(', ') : '');

    const teacherLine = Array.isArray(event.teachers) && event.teachers.length
        ? `Prof(s): ${event.teachers.join(', ')}`
        : '';

    const groupsLine = Array.isArray(event.groups) && event.groups.length
        ? `Groupe(s): ${event.groups.join(', ')}`
        : '';

    const statusLine = event.status ? `Statut: ${event.status}` : '';
    const typeLine = event.type ? `Type: ${event.type}` : '';
    const baseDescription = event.description || '';

    const descriptionParts = [baseDescription, teacherLine, groupsLine, statusLine, typeLine]
        .filter(Boolean);

    const description = descriptionParts.join('\n');

    const uid = event.uid
        || event.id
        || `${event.type || 'event'}-${startDate.getTime()}-${endDate.getTime()}`;

    return {
        uid,
        startDate,
        endDate,
        summary,
        description,
        location: locationFromEvent || '',
    };
}

function buildSingleEventICalendar(event) {
    const calendar = icalGenerator({ name: 'Pronote' });
    calendar.createEvent({
        id: event.uid,
        start: event.startDate,
        end: event.endDate,
        summary: event.summary,
        description: event.description || '',
        location: event.location || '',
    });
    return calendar.toString();
}

// -----------------------------------------------------------------------------
// Public helpers used elsewhere in the project
// -----------------------------------------------------------------------------
function createICSEvent(eventData, filePath) {
    const calendar = icalGenerator({ name: 'Lycee' });

    calendar.createEvent({
        start: new Date(eventData.start),
        end: new Date(eventData.end),
        summary: eventData.summary,
        description: eventData.description || '',
        location: eventData.location || '',
    });

    ensureDirectoryExists(filePath);
    fs.writeFileSync(filePath, calendar.toString());
}

function parseICSEvents(filePath) {
    if (!fs.existsSync(filePath)) {
        throw new Error(`File not found: ${filePath}`);
    }

    const data = fs.readFileSync(filePath, 'utf8');
    const events = nodeIcal.sync.parseICS(data);

    return Object.values(events)
        .filter(event => event.type === 'VEVENT')
        .map(event => ({
            start: event.start,
            end: event.end,
            summary: event.summary,
            description: event.description,
            location: event.location,
        }));
}

function overwriteICSEvents(filePath, newEvents) {
    const calendar = icalGenerator({ name: 'My Calendar' });

    newEvents.forEach(event => {
        const mappedEvent = mapEventToICalFields(event);
        calendar.createEvent({
            id: mappedEvent.uid,
            start: mappedEvent.startDate,
            end: mappedEvent.endDate,
            summary: mappedEvent.summary,
            description: mappedEvent.description || '',
            location: mappedEvent.location || '',
        });
    });

    ensureDirectoryExists(filePath);
    fs.writeFileSync(filePath, calendar.toString());
}

// -----------------------------------------------------------------------------
// Radicale synchronization
// -----------------------------------------------------------------------------
function prepareRadicaleConnection() {
    const serverUrl = secrets.RADICALE_SERVER_URL;
    const username = secrets.RADICALE_USERNAME;
    const password = secrets.RADICALE_PASSWORD;

    if (!serverUrl || !username || !password) {
        throw new Error('Radicale server credentials are missing in secrets.json');
    }

    const serverUrlObject = new URL(serverUrl);
    let basePath = serverUrlObject.pathname || '/';

    if (basePath.endsWith('.ics')) {
        basePath = path.posix.dirname(basePath);
    }

    if (!basePath.endsWith('/')) {
        basePath += '/';
    }

    if (!basePath.startsWith('/')) {
        basePath = `/${basePath}`;
    }

    const baseUrl = `${serverUrlObject.origin}${basePath}`;
    const authHeader = 'Basic ' + Buffer.from(`${username}:${password}`).toString('base64');

    return { baseUrl, authHeader };
}

async function fetchRemotePropfind(baseUrl, authHeader) {
    const body = `<?xml version="1.0" encoding="utf-8"?>
<propfind xmlns="DAV:">
  <prop><getetag/></prop>
</propfind>`;

    try {
        const response = await fetch(baseUrl, {
            method: 'PROPFIND',
            headers: {
                Authorization: authHeader,
                Depth: '1',
                'Content-Type': 'application/xml; charset=utf-8',
            },
            body,
        });

        if (!response.ok && response.status !== 207) {
            throw new Error(`PROPFIND failed with status ${response.status} ${response.statusText}`);
        }

        return await response.text();
    } catch (error) {
        console.error('Failed to fetch Radicale collection listing:', error.message);
        throw error;
    }
}

function parsePropfindResponse(xmlText) {
    const resources = [];
    const responseRegex = /<response[\s\S]*?<\/response>/gi;
    let match;

    while ((match = responseRegex.exec(xmlText)) !== null) {
        const block = match[0];
        const hrefMatch = block.match(/<href>([^<]+)<\/href>/i);
        if (!hrefMatch) continue;

        const rawHref = decodeXml(hrefMatch[1].trim());
        if (rawHref.endsWith('/')) continue; // skip the collection entry itself

        const hrefSegments = rawHref.split('/');
        const fileName = hrefSegments[hrefSegments.length - 1];
        if (!fileName || !fileName.toLowerCase().endsWith('.ics')) continue;

        const decodedFileName = decodeURIComponent(fileName);
        const decodedUid = decodedFileName.replace(/\.ics$/i, '');

        const etagMatch = block.match(/<getetag>([^<]+)<\/getetag>/i);
        const etag = etagMatch ? decodeXml(etagMatch[1].trim()).replace(/^"|"$/g, '') : null;

        resources.push({
            fileName,        // may be percent-encoded
            decodedUid,
            etag,
        });
    }

    return resources;
}

async function putEvent(baseUrl, authHeader, eventData) {
    const resourceName = `${encodeURIComponent(eventData.uid)}.ics`;
    const targetUrl = new URL(resourceName, baseUrl).toString();
    const body = buildSingleEventICalendar(eventData);

    const response = await fetch(targetUrl, {
        method: 'PUT',
        headers: {
            Authorization: authHeader,
            'Content-Type': 'text/calendar; charset=utf-8',
        },
        body,
    });

    if (!response.ok) {
        const errorBody = await response.text().catch(() => '');
        throw new Error(`PUT ${resourceName} failed: ${response.status} ${response.statusText}${errorBody ? ` - ${errorBody}` : ''}`);
    }

    console.log(`Uploaded/updated ${eventData.uid} -> ${targetUrl}`);
}

async function deleteRemoteEvent(baseUrl, authHeader, resourceName) {
    const targetUrl = new URL(resourceName, baseUrl).toString();

    const response = await fetch(targetUrl, {
        method: 'DELETE',
        headers: {
            Authorization: authHeader,
        },
    });

    if (!response.ok && response.status !== 404) {
        const errorBody = await response.text().catch(() => '');
        throw new Error(`DELETE ${resourceName} failed: ${response.status} ${response.statusText}${errorBody ? ` - ${errorBody}` : ''}`);
    }

    console.log(`Deleted remote event ${resourceName}`);
}

async function uploadToRadicale(events, icsFilePath) {
    console.log('Starting Radicale synchronization...');

    if (!Array.isArray(events)) {
        throw new Error('uploadToRadicale expects the Pronote event array as its first argument.');
    }

    if (icsFilePath && !fs.existsSync(icsFilePath)) {
        console.warn(`Local ICS file ${icsFilePath} not found; continuing with remote sync only.`);
    }

    const { baseUrl, authHeader } = prepareRadicaleConnection();
    console.log(`Radicale base URL: ${baseUrl}`);

    const normalizedEvents = new Map();
    events.forEach(event => {
        const mapped = mapEventToICalFields(event);
        normalizedEvents.set(mapped.uid, mapped);
    });

    let remoteResources = [];
    try {
        const propfindXml = await fetchRemotePropfind(baseUrl, authHeader);
        remoteResources = parsePropfindResponse(propfindXml);
    } catch (error) {
        console.error('Unable to list existing Radicale resources, continuing with best effort:', error.message);
    }

    // Upload/update desired events
    for (const mappedEvent of normalizedEvents.values()) {
        try {
            await putEvent(baseUrl, authHeader, mappedEvent);
        } catch (error) {
            console.error(`Failed to sync event ${mappedEvent.uid}:`, error.message);
        }
    }

    // Delete stale events that are no longer in Pronote
    const desiredUids = new Set(normalizedEvents.keys());
    for (const resource of remoteResources) {
        if (!desiredUids.has(resource.decodedUid)) {
            try {
                await deleteRemoteEvent(baseUrl, authHeader, resource.fileName);
            } catch (error) {
                console.error(`Failed to delete remote event ${resource.fileName}:`, error.message);
            }
        }
    }

    console.log('Radicale synchronization finished.');
}

// -----------------------------------------------------------------------------
// Exports
// -----------------------------------------------------------------------------
module.exports = {
    createICSEvent,
    parseICSEvents,
    overwriteICSEvents,
    uploadToRadicale,
};