{ config, inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.file."${config.xdg.configHome}/nixosassets/noctalia" = {
    source = ./assets;
    recursive = true;
  };

  programs.noctalia = {
    enable = true;

    settings = {
      appLauncher = {
        autoPasteClipboard = false;
        clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
        clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
        clipboardWrapText = true;
        customLaunchPrefix = "";
        customLaunchPrefixEnabled = false;
        density = "default";
        enableClipPreview = true;
        enableClipboardChips = true;
        enableClipboardHistory = true;
        enableClipboardSmartIcons = true;
        enableSessionSearch = true;
        enableSettingsSearch = true;
        enableWindowsSearch = true;
        iconMode = "tabler";
        ignoreMouseInput = false;
        overviewLayer = false;
        pinnedApps = [ ];
        position = "center";
        screenshotAnnotationTool = "";
        showCategories = true;
        showIconBackground = false;
        sortByMostUsed = true;
        terminalCommand = "ghostty";
        viewMode = "list";
      };
      audio = {
        enable_overdrive = true;
        enable_sounds = true;
        mprisBlacklist = [ ];
        preferredPlayer = "";
        spectrumFrameRate = 30;
        visualizerType = "linear";
        volumeFeedback = false;
        volumeFeedbackSoundFile = "";
        volumeOverdrive = false;
        volumeStep = 5;
      };

      bar = {
        backgroundOpacity = 0.78;
        barType = "floating";
        capsuleColorKey = "none";
        capsuleOpacity = 1;
        contentPadding = 2;
        density = "default";
        displayMode = "always_visible";
        enableExclusionZoneInset = true;
        floating = true;
        fontScale = 1;
        hideOnOverview = false;
        marginHorizontal = 4;
        marginVertical = 4;
        middleClickAction = "none";
        middleClickCommand = "";
        middleClickFollowMouse = false;
        mouseWheelAction = "none";
        mouseWheelWrap = true;
        outerCorners = true;
        position = "top";
        reverseScroll = false;
        rightClickAction = "controlCenter";
        rightClickCommand = "";
        rightClickFollowMouse = true;
        screenOverrides = [ ];
        showCapsule = false;
        showOnWorkspaceSwitch = true;
        showOutline = false;
        useSeparateOpacity = true;
        widgetSpacing = 6;
        widgets = {
          background_opacity = 0.7499999832361937;
          center = [
            "clock"
            "audio_visualizer"
          ];
          contact_shadow = true;
          end = [
            "tray"
            "media"
            "battery"
            "notifications"
            "session"
          ];
          layer = "top";
          margin_edge = 6;
          margin_ends = 40;
          radius = 80;
          start = [
            "control-center"
            "recorder"
            "group:g1"
            "group:g2"
          ];

          capsule_group = [
            {
              fill = "surface_variant";
              id = "g1";
              members = [
                "network"
                "bluetooth"
              ];
              opacity = 1.0;
              padding = 6.0;
            }
            {
              fill = "surface_variant";
              id = "g2";
              members = [
                "workspaces"
                "active_window"
              ];
              opacity = 0.699999988079071;
              padding = 10.0;
            }
          ];

          left = [
            {
              colorizeDistroLogo = false;
              colorizeSystemIcon = "primary";
              customIconPath = "${config.xdg.configHome}/nixosassets/noctalia/venco.svg";
              enableColorization = true;
              icon = "noctalia";
              id = "ControlCenter";
              useDistroLogo = false;
            }
            {
              displayMode = "onhover";
              iconColor = "none";
              id = "Network";
              textColor = "none";
            }
            {
              displayMode = "onhover";
              iconColor = "none";
              id = "Bluetooth";
              textColor = "none";
            }
          ];

          right = [
            {
              blacklist = [ ];
              chevronColor = "none";
              colorizeIcons = false;
              drawerEnabled = true;
              hidePassive = false;
              id = "Tray";
              pinned = [ ];
            }
            {
              deviceNativePath = "__default__";
              displayMode = "graphic-clean";
              hideIfIdle = false;
              hideIfNotDetected = true;
              id = "Battery";
              showNoctaliaPerformance = false;
              showPowerProfiles = false;
            }
            {
              clockColor = "none";
              customFont = "";
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              tooltipFormat = "HH:mm ddd, MMM dd";
              useCustomFont = false;
            }
          ];
        };
      };

      brightness = {
        backlightDeviceMappings = [ ];
        brightnessStep = 5;
        enableDdcSupport = false;
        enforceMinimum = false;
      };
      calendar = {
        enabled = true;
        cards = [
          {
            enabled = true;
            id = "calendar-header-card";
          }
          {
            enabled = true;
            id = "calendar-month-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
        ];
      };
      colorSchemes = {
        darkMode = true;
        generationMethod = "tonal-spot";
        manualSunrise = "09:00";
        manualSunset = "20:30";
        monitorForColors = "";
        predefinedScheme = "Monochrome";
        schedulingMode = "manual";
        useWallpaperColors = true;
      };
      controlCenter = {
        diskPath = "/";
        position = "close_to_bar_button";
        shortcuts = {
          left = [
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "WallpaperSelector";
            }
            {
              id = "NoctaliaPerformance";
            }
            {
              id = "DarkMode";
            }
          ];
          right = [
            {
              id = "Notifications";
            }
            {
              id = "PowerProfile";
            }
            {
              id = "KeepAwake";
            }
            {
              id = "NightLight";
            }
            {
              enableOnStateLogic = false;
              generalTooltipText = "Restart Noctalia";
              icon = "restore";
              id = "CustomButton";
              onClicked = "killall .quickshell-wrapper && noctalia-shell";
              onMiddleClicked = "";
              onRightClicked = "";
              showExecTooltip = false;
              stateChecksJson = "[]";
            }
          ];
        };
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = false;
            id = "brightness-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];
      };
      control_center = {
        shortcuts = [
          {
            type = "notification";
          }
          {
            type = "caffeine";
          }
          {
            type = "wifi";
          }
          {
            type = "bluetooth";
          }
          {
            type = "dark_mode";
          }
          {
            type = "wallpaper";
          }
        ];
      };
      desktopWidgets = {
        enabled = true;
        gridSnap = true;
        gridSnapScale = true;
        overviewEnabled = true;
        monitorWidgets = [
          {
            name = "HDMI-A-2";
            widgets = [
              {
                clockColor = "none";
                clockStyle = "digital";
                customFont = "";
                format = "HH:mm\nd MMMM yyyy";
                id = "Clock";
                roundedCorners = true;
                scale = 1.2;
                showBackground = true;
                useCustomFont = false;
                x = 20;
                y = 60;
              }
              {
                hideMode = "visible";
                id = "MediaPlayer";
                roundedCorners = true;
                scale = 1;
                showAlbumArt = true;
                showBackground = true;
                showButtons = true;
                showVisualizer = true;
                visualizerType = "linear";
                x = 220;
                y = 60;
              }
              {
                colorName = "primary";
                height = 72;
                hideWhenIdle = false;
                id = "AudioVisualizer";
                roundedCorners = true;
                scale = 5;
                showBackground = false;
                visualizerType = "linear";
                width = 375;
                x = 20;
                y = 720;
              }
              {
                diskPath = "/";
                id = "SystemStat";
                layout = "bottom";
                roundedCorners = true;
                scale = 1;
                showBackground = true;
                statType = "CPU";
                x = 20;
                y = 260;
              }
              {
                id = "Weather";
                roundedCorners = true;
                scale = 1;
                showBackground = true;
                x = 220;
                y = 160;
              }
            ];
          }
        ];
      };
      dock = {
        animationSpeed = 1;
        backgroundOpacity = 1;
        colorizeIcons = false;
        deadOpacity = 0.6;
        displayMode = "always_visible";
        dockType = "floating";
        enabled = false;
        floatingRatio = 0;
        groupApps = false;
        groupClickAction = "cycle";
        groupContextMenuMode = "extended";
        groupIndicatorStyle = "dots";
        inactiveIndicators = false;
        indicatorColor = "primary";
        indicatorOpacity = 0.6;
        indicatorThickness = 3;
        launcherIcon = "";
        launcherIconColor = "none";
        launcherPosition = "end";
        launcherUseDistroLogo = false;
        monitors = [ ];
        onlySameOutput = true;
        pinnedApps = [ ];
        pinnedStatic = false;
        position = "bottom";
        showDockIndicator = false;
        showLauncherIcon = false;
        sitOnFrame = false;
        size = 0.6;
      };
      general = {
        allowPanelsOnScreenWithoutBar = true;
        allowPasswordWithFprintd = false;
        animationDisabled = false;
        animationSpeed = 1;
        autoStartAuth = false;
        avatarImage = "${config.xdg.configHome}/nixosassets/pfp/venco.png";
        boxRadiusRatio = 1;
        clockFormat = "hh\nmm";
        clockStyle = "custom";
        compactLockScreen = false;
        dimmerOpacity = 0.05;
        enableBlurBehind = true;
        enableLockScreenCountdown = true;
        enableLockScreenMediaControls = true;
        enableShadows = true;
        forceBlackScreenCorners = false;
        iRadiusRatio = 1;
        language = "";
        lockOnSuspend = true;
        lockScreenAnimations = true;
        lockScreenBlur = 0.5;
        lockScreenCountdownDuration = 10000;
        lockScreenMonitors = [ ];
        lockScreenTint = 0;
        passwordChars = true;
        radiusRatio = 1;
        reverseScroll = false;
        scaleRatio = 1;
        screenRadiusRatio = 1;
        shadowDirection = "bottom_right";
        shadowOffsetX = 2;
        shadowOffsetY = 3;
        showChangelogOnStartup = true;
        showHibernateOnLockScreen = false;
        showScreenCorners = true;
        showSessionButtonsOnLockScreen = true;
        telemetryEnabled = false;
        keybinds = {
          keyDown = [ "Down" ];
          keyEnter = [
            "Return"
            "Enter"
          ];
          keyEscape = [ "Esc" ];
          keyLeft = [ "Left" ];
          keyRemove = [ "Del" ];
          keyRight = [ "Right" ];
          keyUp = [ "Up" ];
        };
      };
      hooks = {
        colorGeneration = "";
        darkModeChange = "";
        enabled = false;
        performanceModeDisabled = "";
        performanceModeEnabled = "";
        screenLock = "";
        screenUnlock = "";
        session = "";
        startup = "";
        wallpaperChange = "";
      };
      idle = {
        behavior_order = [
          "lock"
          "screen-off"
          "lock-and-suspend"
        ];
        customCommands = "[]";
        enabled = true;
        fadeDuration = 5;
        lockCommand = "";
        lockTimeout = 660;
        resumeLockCommand = "";
        resumeScreenOffCommand = "";
        resumeSuspendCommand = "";
        screenOffCommand = "";
        screenOffTimeout = 600;
        suspendCommand = "";
        suspendTimeout = 1800;
        behavior = {
          lock = {
            action = "lock";
            enabled = true;
            timeout = 600;
          };
          lock-and-suspend = {
            action = "lock_and_suspend";
            enabled = true;
            timeout = 900;
          };
          screen-off = {
            action = "screen_off";
            enabled = true;
            timeout = 660;
          };
        };
      };
      location = {
        analogClockInCalendar = true;
        auto_locate = true;
        firstDayOfWeek = -1;
        hideWeatherCityName = true;
        hideWeatherTimezone = false;
        showCalendarEvents = true;
        showCalendarWeather = true;
        showWeekNumberInCalendar = true;
        use12hourFormat = false;
        useFahrenheit = false;
        weatherEnabled = true;
        weatherShowEffects = true;
      };
      lockscreen = {
        blur_intensity = 0.80;
      };
      lockscreen_widgets = {
        enabled = true;
        schema_version = 2;
        widget_order = [
          "lockscreen-login-box@HDMI-A-2"
          "lockscreen-login-box@DP-2"
          "lockscreen-login-box@DP-1"
          "lockscreen-widget-0000000000000001"
          "lockscreen-widget-0000000000000002"
          "lockscreen-widget-0000000000000003"
          "lockscreen-widget-0000000000000006"
          "lockscreen-widget-0000000000000007"
        ];
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
        widget = {
          "lockscreen-login-box@DP-1" = {
            box_height = 0.0;
            box_width = 0.0;
            cx = 960.0;
            cy = 957.0;
            output = "DP-1";
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_login_button = true;
            };
          };
          "lockscreen-login-box@DP-2" = {
            box_height = 0.0;
            box_width = 0.0;
            cx = 960.0;
            cy = 957.0;
            output = "DP-2";
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_login_button = true;
            };
          };
          "lockscreen-login-box@HDMI-A-2" = {
            box_height = 0.0;
            box_width = 0.0;
            cx = 960.0;
            cy = 979.0;
            output = "HDMI-A-2";
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_login_button = true;
            };
          };
          lockscreen-widget-0000000000000001 = {
            box_height = 192.0;
            box_width = 512.0;
            cx = 960.0;
            cy = 540.0;
            output = "HDMI-A-2";
            rotation = 0.0;
            type = "clock";
            settings = {
              background = true;
              clock_style = "digital";
              font_family = "Google Sans Flex";
              format = "{:%H:%M:%S}";
              shadow = true;
            };
          };
          lockscreen-widget-0000000000000002 = {
            box_height = 144.0;
            box_width = 320.0;
            cx = 860.0;
            cy = 724.0;
            output = "HDMI-A-2";
            rotation = 0.0;
            type = "media_player";
          };
          lockscreen-widget-0000000000000003 = {
            box_height = 176.0;
            box_width = 240.0;
            cx = 824.0;
            cy = 348.0;
            output = "HDMI-A-2";
            rotation = 0.0;
            type = "sysmon";
          };
          lockscreen-widget-0000000000000006 = {
            box_height = 144.0;
            box_width = 176.0;
            cx = 1128.0;
            cy = 724.0;
            output = "HDMI-A-2";
            rotation = 0.0;
            type = "weather";
          };
          lockscreen-widget-0000000000000007 = {
            box_height = 176.0;
            box_width = 240.0;
            cx = 1096.0;
            cy = 348.0;
            output = "HDMI-A-2";
            rotation = 0.0;
            type = "sysmon";
            settings = {
              stat = "ram_pct";
            };
          };
        };
      };
      network = {
        airplaneModeEnabled = false;
        bluetoothAutoConnect = true;
        bluetoothDetailsViewMode = "grid";
        bluetoothHideUnnamedDevices = false;
        bluetoothRssiPollIntervalMs = 60000;
        bluetoothRssiPollingEnabled = false;
        disableDiscoverability = false;
        networkPanelView = "wifi";
        wifiDetailsViewMode = "grid";
        wifiEnabled = true;
      };
      nightLight = {
        autoSchedule = true;
        dayTemp = "6500";
        enabled = false;
        forced = false;
        manualSunrise = "06:30";
        manualSunset = "18:30";
        nightTemp = "2006";
      };
      noctaliaPerformance = {
        disableDesktopWidgets = true;
        disableWallpaper = true;
      };
      notifications = {
        backgroundOpacity = 0.78;
        clearDismissed = true;
        criticalUrgencyDuration = 15;
        density = "default";
        enableBatteryToast = true;
        enableKeyboardLayoutToast = true;
        enableMarkdown = false;
        enableMediaToast = false;
        enabled = true;
        location = "top_right";
        lowUrgencyDuration = 3;
        monitors = [ ];
        normalUrgencyDuration = 8;
        overlayLayer = true;
        respectExpireTimeout = false;
        saveToHistory = {
          critical = true;
          low = true;
          normal = true;
        };
        sounds = {
          criticalSoundFile = "";
          enabled = false;
          excludedApps = "discord,firefox,chrome,chromium,edge";
          lowSoundFile = "";
          normalSoundFile = "";
          separateSounds = false;
          volume = 0.5;
        };
      };
      osd = {
        autoHideMs = 2000;
        backgroundOpacity = 1;
        enabled = true;
        enabledTypes = [
          0
          1
          2
          3
        ];
        location = "top_right";
        monitors = [ ];
        overlayLayer = true;
      };
      plugins = {
        autoUpdate = false;
        enabled = [ "noctalia/screen_recorder" ];
        notifyUpdates = true;
      };
      sessionMenu = {
        countdownDuration = 10000;
        enableCountdown = true;
        largeButtonsLayout = "single-row";
        largeButtonsStyle = true;
        position = "center";
        showHeader = true;
        showKeybinds = true;
        powerOptions = [
          {
            action = "lock";
            command = "";
            countdownEnabled = false;
            enabled = true;
            keybind = "1";
          }
          {
            action = "suspend";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "2";
          }
          {
            action = "hibernate";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "3";
          }
          {
            action = "reboot";
            command = "";
            countdownEnabled = false;
            enabled = true;
            keybind = "4";
          }
          {
            action = "logout";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "5";
          }
          {
            action = "shutdown";
            command = "";
            countdownEnabled = false;
            enabled = true;
            keybind = "6";
          }
          {
            action = "rebootToUefi";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "7";
          }
          {
            action = "userspaceReboot";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "8";
          }
        ];
      };
      shell = {
        app_icon_color = "primary";
        app_icon_colorize = true;
        avatar_path = "${config.xdg.configHome}/nixosassets/pfp/venco.png";
        corner_radius_scale = 1.5000000223517418;
        font_family = "Google Sans Flex";
        niri_overview_type_to_launch_enabled = true;
        offline_mode = false;
        password_style = "random";
        polkit_agent = true;
        screen_time_enabled = true;
        settings_show_advanced = true;
        panel = {
          control_center_placement = "floating";
          launcher_compact = true;
          open_near_click_clipboard = true;
          open_near_click_control_center = true;
          transparency_mode = "glass";
        };
        screen_corners = {
          enabled = true;
        };
        shadow = {
          direction = "down_right";
        };
      };
      systemMonitor = {
        batteryCriticalThreshold = 5;
        batteryWarningThreshold = 20;
        cpuCriticalThreshold = 90;
        cpuWarningThreshold = 80;
        criticalColor = "";
        diskAvailCriticalThreshold = 10;
        diskAvailWarningThreshold = 20;
        diskCriticalThreshold = 90;
        diskWarningThreshold = 80;
        enableDgpuMonitoring = false;
        externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
        gpuCriticalThreshold = 90;
        gpuWarningThreshold = 80;
        memCriticalThreshold = 90;
        memWarningThreshold = 80;
        swapCriticalThreshold = 90;
        swapWarningThreshold = 80;
        tempCriticalThreshold = 90;
        tempWarningThreshold = 80;
        useCustomColors = false;
        warningColor = "";
      };
      templates = {
        activeTemplates = [ ];
        enableUserTheming = false;
      };
      theme = {
        builtin = "Tokyo-Night";
        mode = "dark";
        source = "wallpaper";
        templates = {
          builtin_ids = [
            "gtk3"
            "gtk4"
            "kcolorscheme"
            "qt"
          ];
        };
      };
      ui = {
        boxBorderEnabled = false;
        fontDefault = "SF Pro Display";
        fontDefaultScale = 1;
        fontFixed = "SF Mono";
        fontFixedScale = 1;
        panelBackgroundOpacity = 0.93;
        panelsAttachedToBar = true;
        scrollbarAlwaysVisible = true;
        settingsPanelMode = "window";
        settingsPanelSideBarCardStyle = false;
        tooltipsEnabled = true;
        translucentWidgets = true;
      };
      wallpaper = {
        automationEnabled = false;
        directory = "/home/venco/Pictures/Wallpapers";
        directory_dark = "/home/venco/Pictures/Wallpapers";
        directory_light = "/home/venco/Pictures/Wallpapers";
        enableMultiMonitorDirectories = false;
        enabled = true;
        favorites = [ ];
        fillColor = "#000000";
        fillMode = "crop";
        hideWallpaperFilenames = false;
        monitorDirectories = [ ];
        overviewBlur = 0.4;
        overviewEnabled = false;
        overviewTint = 0.6;
        panelPosition = "follow_bar";
        randomIntervalSec = 300;
        setWallpaperOnAllMonitors = true;
        showHiddenFiles = true;
        skipStartupTransition = false;
        solidColor = "#1a1a2e";
        sortOrder = "name";
        transitionDuration = 1500;
        transitionEdgeSmoothness = 0.05;
        transitionType = [
          "fade"
          "disc"
          "stripes"
          "wipe"
          "pixelate"
          "honeycomb"
        ];
        transition_on_startup = true;
        useSolidColor = false;
        useWallhaven = false;
        viewMode = "single";
        wallhavenApiKey = "";
        wallhavenCategories = "111";
        wallhavenOrder = "desc";
        wallhavenPurity = "100";
        wallhavenQuery = "";
        wallhavenRatios = "";
        wallhavenResolutionHeight = "";
        wallhavenResolutionMode = "atleast";
        wallhavenResolutionWidth = "";
        wallhavenSorting = "relevance";
        wallpaperChangeMode = "random";
        default = {
          path = "/home/venco/Pictures/Wallpapers/wallhaven-jeeq3q.png";
        };
        last = {
          path = "/home/venco/Pictures/Wallpapers/wallhaven-jeeq3q.png";
        };
        monitors = {
          DP-1 = {
            path = "/home/venco/Pictures/Wallpapers/wallhaven-jeeq3q.png";
          };
          DP-2 = {
            path = "/home/venco/Pictures/Wallpapers/wallhaven-jeeq3q.png";
          };
          HDMI-A-2 = {
            path = "/home/venco/Pictures/Wallpapers/wallhaven-jeeq3q.png";
          };
        };
      };
      widget = {
        control-center = {
          capsule_padding = 0.0;
          color = "primary";
          custom_image_colorize = true;
          font_weight = 380;
          glyph = "box-multiple-filled";
        };
        media = {
          capsule = true;
          hide_when_no_media = true;
          title_scroll = "always";
        };
        network = {
          capsule = true;
          show_label = false;
        };
        recorder = {
          type = "noctalia/screen_recorder:recorder";
        };
        tray = {
          drawer = true;
        };
        workspaces = {
          capsule = true;
          labels_only_when_occupied = true;
          max_label_chars = 3;
        };
      };
    };
  };
}
