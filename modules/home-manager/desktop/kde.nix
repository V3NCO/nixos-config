{ ... }:
{
  home.file.".local/share/plasma".source = ./kde/localplasma;
  home.file.".local/share/color-schemes/KanagawaWave.colors".source = ./kde/KanagawaWave.colors;
  programs.plasma = {
    enable = true;
    panels = [
      {
        location = "bottom";
        opacity = "translucent";
        lengthMode = "fit";
        hiding = "dodgewindows";
        alignment = "left";
        floating = true;
        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config = { Global = { icon = "choice-rhomb"; }; };
          }
          "org.kde.plasma.marginsseparator"
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General = {
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "applications:dev.zed.Zed.desktop"
                  "applications:zen-twilight.desktop"
                ];
              };
            };
          }
        ];
        height = 44;
      }
      {
        location = "bottom";
        opacity = "translucent";
        lengthMode = "fit";
        hiding = "dodgewindows";
        alignment = "right";
        floating = true;
        widgets = [
          {
            name = "org.kde.plasma.systemtray";
            config = {
              General = {
                disabledStatusNotifiers = "com.core447.StreamController.TrayIcon";
                extraItems = [
                  "org.kde.plasma.mediacontroller"
                  "org.kde.plasma.volume"
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.devicenotifier"
                  "org.kde.kscreen"
                  "org.kde.kdeconnect"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.battery"
                  "org.kde.plasma.printmanager"
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.notifications"
                  "org.kde.plasma.trash"
                ];
                hiddenItems = [
                  "org.kde.plasma.volume"
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.devicenotifier"
                  "org.kde.kscreen"
                  "org.kde.kdeconnect"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.battery"
                  "org.kde.plasma.printmanager"
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.notifications"
                  "org.kde.plasma.trash"
                ];
                knownItems = [
                  "org.kde.plasma.kclock_1x2"
                  "org.kde.kdeconnect"
                  "org.kde.plasma.mediacontroller"
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.cameraindicator"
                  "org.kde.plasma.devicenotifier"
                  "org.kde.plasma.notifications"
                  "org.kde.plasma.manage-inputmethod"
                  "org.kde.plasma.battery"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.printmanager"
                  "org.kde.plasma.volume"
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.keyboardlayout"
                  "org.kde.kscreen"
                  "org.kde.plasma.weather"
                  "org.kde.plasma.keyboardindicator"
                ];
              };
            };
            applets = [
              { plugin = "org.kde.kdeconnect"; }
              { plugin = "org.kde.plasma.clipboard"; }
              { plugin = "org.kde.plasma.devicenotifier"; }
              { plugin = "org.kde.plasma.notifications"; }
              { plugin = "org.kde.plasma.printmanager"; }
              {
                plugin = "org.kde.plasma.volume";
                config = { General = { migrated = true; }; };
              }
              { plugin = "org.kde.plasma.networkmanagement"; }
              { plugin = "org.kde.kscreen"; }
              { plugin = "org.kde.plasma.battery"; }
              { plugin = "org.kde.plasma.brightness"; }
              { plugin = "org.kde.plasma.trash"; }
            ];
          }
        ];
      }
      {
        location = "bottom";
        opacity = "translucent";
        lengthMode = "fit";
        hiding = "dodgewindows";
        alignment = "right";
        floating = true;
        widgets = [
          {
            name = "org.kde.plasma.digitalclock";
            config = {
              Appearance = {
                fontFamily = "Google Sans Flex";
                fontSize = 14;
                fontStyleName = "Regular";
                fontWeight = 600;
                showDate = false;
                time.format = "12h";
              };
            };
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.showdesktop"
        ];
        height = 44;
      }
    ];

    workspace = {
      windowDecorations = {
        library = "org.kde.klassy";
        theme = "Klassy";
      };

      widgetStyle = "Darkly";
      theme = "Ant-Dark";
      lookAndFeel = "Ant-Dark";
      iconTheme = "Fluent-dark";
      colorScheme = "KanagawaWave";

      cursor = {
        cursorFeedback = "None";
        theme = "Bibata-Modern-Ice";
      };

      splashScreen = {
        engine = "KSplashQML";
        theme = "Lagtrain";
      };


    };

    shortcuts = {
      "KDE Keyboard Layout Switcher"."Switch to Last-Used Keyboard Layout" = "Meta+Alt+L";
      "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "Meta+Alt+K";
      kaccess."Toggle Screen Reader On and Off" = "Meta+Alt+S";
      kmix.decrease_microphone_volume = "Microphone Volume Down";
      kmix.decrease_volume = "Volume Down";
      kmix.decrease_volume_small = "Shift+Volume Down";
      kmix.increase_microphone_volume = "Microphone Volume Up";
      kmix.increase_volume = "Volume Up";
      kmix.increase_volume_small = "Shift+Volume Up";
      kmix.mic_mute = ["Microphone Mute" "Meta+Volume Mute"];
      kmix.mute = "Volume Mute";
      ksmserver."Lock Session" = ["Meta+L" "Screensaver"];
      ksmserver."Log Out" = "Ctrl+Alt+Del";
      kwin."Activate Window Demanding Attention" = "Meta+Ctrl+A";
      kwin."Edit Tiles" = "Meta+T";
      kwin.Expose = ["Meta+F9" "Ctrl+F9"];
      kwin.ExposeAll = ["Meta+F10" "Launch (C)" "Ctrl+F10"];
      kwin.ExposeClass = ["Meta+F7" "Ctrl+F7"];
      kwin."Grid View" = "Meta+G";
      kwin."Kill Window" = "Meta+Ctrl+Esc";
      kwin.MoveMouseToCenter = "Meta+F6";
      kwin.MoveMouseToFocus = "Meta+F5";
      kwin.Overview = "Meta+W";
      kwin."Show Desktop" = "Meta+D";
      kwin."Switch One Desktop Down" = "Meta+Ctrl+Down";
      kwin."Switch One Desktop Up" = "Meta+Ctrl+Up";
      kwin."Switch One Desktop to the Left" = "Meta+Ctrl+Left";
      kwin."Switch One Desktop to the Right" = "Meta+Ctrl+Right";
      kwin."Switch Window Down" = "Meta+Alt+Down";
      kwin."Switch Window Left" = "Meta+Alt+Left";
      kwin."Switch Window Right" = "Meta+Alt+Right";
      kwin."Switch Window Up" = "Meta+Alt+Up";
      kwin."Switch to Desktop 1" = ["Meta+F1" "Ctrl+F1"];
      kwin."Switch to Desktop 2" = ["Meta+F2" "Ctrl+F2"];
      kwin."Switch to Desktop 3" = ["Meta+F3" "Ctrl+F3"];
      kwin."Switch to Desktop 4" = ["Meta+F4" "Ctrl+F4"];
      kwin."Walk Through Windows" = ["Meta+Tab" "Alt+Tab"];
      kwin."Walk Through Windows (Reverse)" = ["Meta+Shift+Tab" "Alt+Shift+Tab"];
      kwin."Walk Through Windows of Current Application" = ["Meta+`" "Alt+`"];
      kwin."Walk Through Windows of Current Application (Reverse)" = ["Meta+~" "Alt+~"];
      kwin."Window Maximize" = ["Meta+PgUp" "Meta+F"];
      kwin."Window Minimize" = "Meta+PgDown";
      kwin."Window One Desktop Down" = "Meta+Ctrl+Shift+Down";
      kwin."Window One Desktop Up" = "Meta+Ctrl+Shift+Up";
      kwin."Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left";
      kwin."Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right";
      kwin."Window Operations Menu" = "Alt+F3";
      kwin."Window Quick Tile Bottom" = "Meta+Down";
      kwin."Window Quick Tile Left" = "Meta+Left";
      kwin."Window Quick Tile Right" = "Meta+Right";
      kwin."Window Quick Tile Top" = "Meta+Up";
      kwin."Window to Next Screen" = "Meta+Shift+Right";
      kwin."Window to Previous Screen" = "Meta+Shift+Left";
      kwin.disableInputCapture = "Meta+Shift+Esc";
      kwin.view_actual_size = "Meta+0";
      kwin.view_zoom_in = ["Meta++" "Meta+="];
      kwin.view_zoom_out = "Meta+-";
      mediacontrol.nextmedia = "Media Next";
      mediacontrol.pausemedia = "Media Pause";
      mediacontrol.playpausemedia = "Media Play";
      mediacontrol.previousmedia = "Media Previous";
      mediacontrol.seekbackwardmedia = "Media Rewind";
      mediacontrol.seekforwardmedia = "Media Fast Forward";
      mediacontrol.stopmedia = "Media Stop";
      "org.chromium.Chromium"."05FB7F21ED9AD5D202EF70C866C53BE7-MediaNextTrack" = [ ];
      "org.chromium.Chromium"."07A12634CEA42BC799C2AA84752595DB-MediaPlayPause" = [ ];
      "org.chromium.Chromium"."3F897132107C3623C556B10936088E96-MediaPrevTrack" = [ ];
      "org.chromium.Chromium"."4284A83814160E0CDBB7B5BF19A50EB5-MediaStop" = [ ];
      org_kde_powerdevil."Decrease Keyboard Brightness" = "Keyboard Brightness Down";
      org_kde_powerdevil."Decrease Screen Brightness" = "Monitor Brightness Down";
      org_kde_powerdevil."Decrease Screen Brightness Small" = "Shift+Monitor Brightness Down";
      org_kde_powerdevil.Hibernate = "Hibernate";
      org_kde_powerdevil."Increase Keyboard Brightness" = "Keyboard Brightness Up";
      org_kde_powerdevil."Increase Screen Brightness" = "Monitor Brightness Up";
      org_kde_powerdevil."Increase Screen Brightness Small" = "Shift+Monitor Brightness Up";
      org_kde_powerdevil.PowerDown = "Power Down";
      org_kde_powerdevil.PowerOff = "Power Off";
      org_kde_powerdevil.Sleep = "Sleep";
      org_kde_powerdevil."Toggle Keyboard Backlight" = "Keyboard Light On/Off";
      org_kde_powerdevil.powerProfile = ["Battery" "Meta+B"];
      plasmashell."activate application launcher" = ["Meta" "Alt+F1"];
      plasmashell."activate task manager entry 1" = "Meta+1";
      plasmashell."activate task manager entry 2" = "Meta+2";
      plasmashell."activate task manager entry 3" = "Meta+3";
      plasmashell."activate task manager entry 4" = "Meta+4";
      plasmashell."activate task manager entry 5" = "Meta+5";
      plasmashell."activate task manager entry 6" = "Meta+6";
      plasmashell."activate task manager entry 7" = "Meta+7";
      plasmashell."activate task manager entry 8" = "Meta+8";
      plasmashell."activate task manager entry 9" = "Meta+9";
      plasmashell.clipboard_action = "Meta+Ctrl+X";
      plasmashell.cycle-panels = "Meta+Alt+P";
      plasmashell."manage activities" = [ ];
      plasmashell."next activity" = "Meta+A";
      plasmashell."previous activity" = "Meta+Shift+A";
      plasmashell."show dashboard" = "Ctrl+F12";
      plasmashell.show-on-mouse-pos = "Meta+V";
      "services/com.mitchellh.ghostty.desktop"._launch = [ ];
      "services/org.kde.spectacle.desktop".CurrentMonitorScreenShot = [ ];
      "services/org.kde.spectacle.desktop".OpenWithoutScreenshot = [ ];
    };
    configFile = {
      baloofilerc.General.dbVersion = 2;
      dolphinrc.General.ViewPropsTimestamp = "2025,8,26,21,26,46.498";
      dolphinrc."KFileDialog Settings"."Places Icons Auto-resize" = false;
      dolphinrc."KFileDialog Settings"."Places Icons Static Size" = 22;
      kactivitymanagerdrc.activities."7d383e1a-11e9-4bf5-b2fd-178d5a693cd7" = "Default";
      katerc.General."Days Meta Infos" = 30;
      katerc.General.PinnedDocuments = "";
      katerc.General."Save Meta Infos" = true;
      katerc.General."Show Full Path in Title" = false;
      katerc.General."Show Menu Bar" = true;
      katerc.General."Show Status Bar" = true;
      katerc.General."Show Tab Bar" = true;
      katerc.General."Show Url Nav Bar" = true;
      katerc.filetree.editShade = "36,87,114";
      katerc.filetree.listMode = false;
      katerc.filetree.middleClickToClose = false;
      katerc.filetree.shadingEnabled = true;
      katerc.filetree.showCloseButton = false;
      katerc.filetree.showFullPathOnRoots = false;
      katerc.filetree.showToolbar = true;
      katerc.filetree.sortRole = 0;
      katerc.filetree.viewShade = "67,67,105";
      kded5rc.Module-device_automounter.autoload = false;
      kdeglobals.KDE.AnimationDurationFactor = 0.7071067811865475;
      kdeglobals.KDE.contrast = 0;
      kdeglobals.KDE.frameContrast = 0.2;
      kdeglobals.KDE.widgetStyle = "Darkly";
      kdeglobals.Shortcuts.Quit = "Meta+Q; Ctrl+Q";
      kdeglobals.WM.activeBackground = "34,34,34";
      kdeglobals.WM.activeBlend = "255,255,255";
      kdeglobals.WM.activeForeground = "204,204,204";
      kdeglobals.WM.inactiveBackground = "44,44,44";
      kdeglobals.WM.inactiveBlend = "44,44,44";
      kdeglobals.WM.inactiveForeground = "144,144,144";
      klaunchrc.BusyCursorSettings.Bouncing = false;
      klaunchrc.FeedbackStyle.BusyCursor = false;
      kwalletrc.Wallet."First Use" = false;
      kwinrc.Desktops.Id_1 = "9458cdb0-aa1f-445d-84a1-31ccc9188ada";
      kwinrc.Desktops.Number = 1;
      kwinrc.Desktops.Rows = 1;
      kwinrc.Effect-overview.BorderActivate = 9;
      kwinrc.ElectricBorders.BottomLeft = "ApplicationLauncher";
      kwinrc.Plugins.wobblywindowsEnabled = true;
      kwinrc."Tiling/9458cdb0-aa1f-445d-84a1-31ccc9188ada/26a4d4a6-196d-47de-89d1-48d54f6b1ee1".padding = 4;
      kwinrc."Tiling/9458cdb0-aa1f-445d-84a1-31ccc9188ada/26a4d4a6-196d-47de-89d1-48d54f6b1ee1".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":\x5b{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}\x5d}";
      kwinrc."Tiling/9458cdb0-aa1f-445d-84a1-31ccc9188ada/a5c2ca80-e47c-4bbb-bd63-c5c87b6ed4df".padding = 4;
      kwinrc."Tiling/9458cdb0-aa1f-445d-84a1-31ccc9188ada/a5c2ca80-e47c-4bbb-bd63-c5c87b6ed4df".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":\x5b{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}\x5d}";
      kwinrc."Tiling/9458cdb0-aa1f-445d-84a1-31ccc9188ada/f17c87b4-d4aa-464e-8016-ced5bdc14d2a".padding = 4;
      kwinrc."Tiling/9458cdb0-aa1f-445d-84a1-31ccc9188ada/f17c87b4-d4aa-464e-8016-ced5bdc14d2a".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":\x5b{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}\x5d}";
      kwinrc.Xwayland.Scale = 1;
      kwinrc."org.kde.kdecoration2".theme = "Klassy";
      plasma-localerc.Formats.LANG = "en_US.UTF-8";
      plasmanotifyrc."Applications/slack".Seen = true;
      plasmanotifyrc.Notifications.PopupPosition = "TopRight";
      spectaclerc.ImageSave.translatedScreenshotsFolder = "Screenshots";
      spectaclerc.VideoSave.translatedScreencastsFolder = "Screencasts";
    };
    dataFile = {
      "kate/anonymous.katesession"."Kate Plugins".bookmarksplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".cmaketoolsplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".compilerexplorer = false;
      "kate/anonymous.katesession"."Kate Plugins".eslintplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".externaltoolsplugin = true;
      "kate/anonymous.katesession"."Kate Plugins".formatplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katebacktracebrowserplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katebuildplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katecloseexceptplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katecolorpickerplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katectagsplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katefilebrowserplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katefiletreeplugin = true;
      "kate/anonymous.katesession"."Kate Plugins".kategdbplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".kategitblameplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katekonsoleplugin = true;
      "kate/anonymous.katesession"."Kate Plugins".kateprojectplugin = true;
      "kate/anonymous.katesession"."Kate Plugins".katereplicodeplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katesearchplugin = true;
      "kate/anonymous.katesession"."Kate Plugins".katesnippetsplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katesqlplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katesymbolviewerplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katexmlcheckplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".katexmltoolsplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".keyboardmacrosplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".ktexteditorpreviewplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".latexcompletionplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".lspclientplugin = true;
      "kate/anonymous.katesession"."Kate Plugins".openlinkplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".rainbowparens = false;
      "kate/anonymous.katesession"."Kate Plugins".rbqlplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".tabswitcherplugin = true;
      "kate/anonymous.katesession"."Kate Plugins".templateplugin = false;
      "kate/anonymous.katesession"."Kate Plugins".textfilterplugin = true;
      "kate/anonymous.katesession".MainWindow0."Active ViewSpace" = 0;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-H-Splitter = "0,595,0";
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-0-Bar-0-TvList = "kate_private_plugin_katefiletreeplugin,kateproject,kateprojectgit,lspclient_symbol_outline";
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-0-LastSize = 200;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-0-SectSizes = 0;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-0-Splitter = 371;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-1-Bar-0-TvList = "";
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-1-LastSize = 200;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-1-SectSizes = 0;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-1-Splitter = 371;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-2-Bar-0-TvList = "";
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-2-LastSize = 200;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-2-SectSizes = 0;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-2-Splitter = 595;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-3-Bar-0-TvList = "output,diagnostics,kate_plugin_katesearch,kateprojectinfo,kate_private_plugin_katekonsoleplugin";
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-3-LastSize = 200;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-3-SectSizes = 0;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-3-Splitter = 640;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-Style = 2;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-Sidebar-Visible = true;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-diagnostics-Position = 3;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-diagnostics-Show-Button-In-Sidebar = true;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-diagnostics-Visible = false;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kate_plugin_katesearch-Position = 3;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kate_plugin_katesearch-Show-Button-In-Sidebar = true;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kate_plugin_katesearch-Visible = false;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Position = 0;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Show-Button-In-Sidebar = true;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Visible = false;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Position = 3;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Show-Button-In-Sidebar = true;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Visible = false;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kateproject-Position = 0;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kateproject-Show-Button-In-Sidebar = true;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kateproject-Visible = false;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kateprojectgit-Position = 0;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kateprojectgit-Show-Button-In-Sidebar = true;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kateprojectgit-Visible = false;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kateprojectinfo-Position = 3;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kateprojectinfo-Show-Button-In-Sidebar = true;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-kateprojectinfo-Visible = false;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-lspclient_symbol_outline-Position = 0;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-lspclient_symbol_outline-Show-Button-In-Sidebar = true;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-lspclient_symbol_outline-Visible = false;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-output-Position = 3;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-output-Show-Button-In-Sidebar = true;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-ToolView-output-Visible = false;
      "kate/anonymous.katesession".MainWindow0.Kate-MDI-V-Splitter = "0,371,0";
      "kate/anonymous.katesession"."MainWindow0 Settings".WindowState = 8;
      "kate/anonymous.katesession"."MainWindow0-Splitter 0".Children = "MainWindow0-ViewSpace 0";
      "kate/anonymous.katesession"."MainWindow0-Splitter 0".Orientation = 1;
      "kate/anonymous.katesession"."MainWindow0-Splitter 0".Sizes = 595;
      "kate/anonymous.katesession"."MainWindow0-ViewSpace 0".Count = 0;
      "kate/anonymous.katesession"."Open Documents".Count = 0;
      "kate/anonymous.katesession"."Open MainWindows".Count = 1;
      "kate/anonymous.katesession"."Plugin:kateprojectplugin:".projects = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".BinaryFiles = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".CurrentExcludeFilter = "-1";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".CurrentFilter = "-1";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".ExcludeFilters = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".ExpandSearchResults = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".Filters = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".FollowSymLink = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".HiddenFiles = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".MatchCase = false;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".Place = 1;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".Recursive = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".Replaces = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".Search = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".SearchAsYouTypeAllProjects = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".SearchAsYouTypeCurrentFile = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".SearchAsYouTypeFolder = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".SearchAsYouTypeOpenFiles = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".SearchAsYouTypeProject = true;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".SearchDiskFiles = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".SearchDiskFiless = "";
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".SizeLimit = 128;
      "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0".UseRegExp = false;
    };
  };
}
