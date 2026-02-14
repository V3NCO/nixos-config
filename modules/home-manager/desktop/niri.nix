{ ... }:
{
  programs.niri.settings = {
    input = {
      touchpad.tap = false;
      mouse.accel-speed = -0.5;
      warp-mouse-to-focus.enable = true;
      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "30%";
      };
    };

    layout = {
      center-focused-column = "never";

      preset-column-widths = [
        { proportion = 1. / 3.; }
        { proportion = 1. / 2.; }
        { proportion = 1. / 3.; }
      ];
      default-column-width.proportion = 0.5;

      focus-ring = {
        enable = true;
        width = 4;
        inactive.color = "#505050";
        active.gradient = { from="#9683ec"; to="#6f00ffff"; angle=135; };
      };

      # shadow {
      # // off by default (not enabling to keep things light)
      # softness 30
      # spread 5
      # offset x=0 y=5
      # color "#0007"
      # }
    };

    spawn-at-startup = [
      { argv = ["xwayland-satellite"]; }
      { argv = ["soteria"]; }
      { argv = ["clipse" "-listen"]; }
    ];
    environment = {
      QT_QPA_PLATFORM = "wayland";
      DISPLAY = ":0";
      XDG_CURRENT_DESKTOP = "niri";
    };

    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
    prefer-no-csd = true;

    window-rules = [
      {
        matches = [ { app-id = "^org\.wezfurlong\.wezterm$"; } ];
        default-column-width = {};
      }
      {
        matches = [
          {
            app-id = "firefox$";
            title="^Picture-in-Picture$";
          }
        ];
        open-floating = true;
      }
      {
        geometry-corner-radius = {
          top-right = 12.0;
          top-left = 12.0;
          bottom-right = 12.0;
          bottom-left = 12.0;
        };
        clip-to-geometry = true;
      }
      {
        matches = [ {app-id="clipse";} ];
        open-floating=true;
        open-focused=true;
        default-window-height.proportion = 0.5;
        default-column-width.proportion = 0.5;
      }

      {
        matches = [ {app-id = "signal";} ];
        block-out-from = "screen-capture";
      }
    ];

    layer-rules = [
      {
        matches = [ {namespace="^wallpaper$";} ];
        place-within-backdrop=true;
      }
    ];

    binds = {
      # Media control
      "XF86AudioRaiseVolume" = { action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"]; allow-when-locked = true; };
      "XF86AudioLowerVolume" = { action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"]; allow-when-locked = true; };
      "XF86AudioMute" = { action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"]; allow-when-locked = true; };
      "XF86AudioMicMute" = { action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"]; allow-when-locked = true; };
      "XF86AudioPlay" = { action.spawn = ["playerctl" "play-pause"]; allow-when-locked = true; };
      "XF86AudioPrev" = { action.spawn = ["playerctl" "previous"]; allow-when-locked = true; };
      "XF86AudioNext" = { action.spawn = ["playerctl" "next"]; allow-when-locked = true; };

      # Basics
      "Mod+O" = { repeat = false; action.toggle-overview = []; };
      "Mod+Q".action.close-window = [];

      # Apps
      "Mod+Return".action.spawn = ["kitty"];

      # Layout
      "Mod+Left".action.focus-column-left = [];
      "Mod+Down".action.focus-window-down = [];
      "Mod+Up".action.focus-window-up = [];
      "Mod+Right".action.focus-column-right = [];
      "Mod+H".action.focus-column-left = [];
      "Mod+J".action.focus-window-down = [];
      "Mod+K".action.focus-window-up = [];
      "Mod+L".action.focus-column-right = [];

      "Mod+Ctrl+Left".action.move-column-left = [];
      "Mod+Ctrl+Down".action.move-window-down = [];
      "Mod+Ctrl+Up".action.move-window-up = [];
      "Mod+Ctrl+Right".action.move-column-right = [];
      "Mod+Ctrl+H".action.move-column-left = [];
      "Mod+Ctrl+J".action.move-window-down = [];
      "Mod+Ctrl+K".action.move-window-up = [];
      "Mod+Ctrl+L".action.move-column-right = [];

      "Mod+Home".action.focus-column-first = [];
      "Mod+End".action.focus-column-last = [];
      "Mod+Ctrl+Home".action.move-column-to-first = [];
      "Mod+Ctrl+End".action.move-column-to-last = [];

      "Mod+Shift+Left".action.focus-monitor-left = [];
      "Mod+Shift+Down".action.focus-monitor-down = [];
      "Mod+Shift+Up".action.focus-monitor-up = [];
      "Mod+Shift+Right".action.focus-monitor-right = [];
      "Mod+Shift+H".action.focus-monitor-left = [];
      "Mod+Shift+J".action.focus-monitor-down = [];
      "Mod+Shift+K".action.focus-monitor-up = [];
      "Mod+Shift+L".action.focus-monitor-right = [];

      "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = [];
      "Mod+Shift+Ctrl+Down".action.move-window-to-monitor-down = [];
      "Mod+Shift+Ctrl+Up".action.move-window-to-monitor-up = [];
      "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = [];
      "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = [];
      "Mod+Shift+Ctrl+J".action.move-window-to-monitor-down = [];
      "Mod+Shift+Ctrl+K".action.move-window-to-monitor-up = [];
      "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [];

      "Mod+Page_Down".action.focus-workspace-down = [];
      "Mod+Page_Up".action.focus-workspace-up = [];
      "Mod+U".action.focus-workspace-down = [];
      "Mod+I".action.focus-workspace-up = [];
      "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [];
      "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = [];
      "Mod+Ctrl+U".action.move-column-to-workspace-down = [];
      "Mod+Ctrl+I".action.move-column-to-workspace-up = [];

      "Mod+Shift+Page_Down".action.move-workspace-down = [];
      "Mod+Shift+Page_Up".action.move-workspace-up = [];
      "Mod+Shift+U".action.move-workspace-down = [];
      "Mod+Shift+I".action.move-workspace-up = [];

      "Mod+WheelScrollDown" = { action.focus-workspace-down = []; cooldown-ms=150; };
      "Mod+WheelScrollUp" = { action.focus-workspace-up = []; cooldown-ms=150; };
      "Mod+Ctrl+WheelScrollDown" = { action.move-column-to-workspace-down = []; cooldown-ms=150; };
      "Mod+Ctrl+WheelScrollUp" = { action.move-column-to-workspace-up = []; cooldown-ms=150; };

      "Mod+WheelScrollRight".action.focus-column-right = [];
      "Mod+WheelScrollLeft".action.focus-column-left = [];
      "Mod+Ctrl+WheelScrollRight".action.move-column-right = [];
      "Mod+Ctrl+WheelScrollLeft".action.move-column-left = [];

      "Mod+Shift+WheelScrollRight".action.focus-column-right = [];
      "Mod+Shift+WheelScrollLeft".action.focus-column-left = [];
      "Mod+Shift+Ctrl+WheelScrollRight".action.move-column-right = [];
      "Mod+Shift+Ctrl+WheelScrollLeft".action.move-column-left = [];

      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      "Mod+V".action.toggle-window-floating = [];
      "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [];
      "Mod+W".action.toggle-column-tabbed-display = [];

      # Screenshotting
      "Print".action.screenshot = [];
      "Ctrl+Print".action.screenshot-screen = [];
      "Alt+Print".action.screenshot-window = [];

      # Inhibit
      "Mod+Escape" = { action.toggle-keyboard-shortcuts-inhibit = []; allow-inhibiting=false; };


      # Sleep/Logout
      "Mod+Shift+E".action.quit = [];
      "Ctrl+Alt+Delete".action.quit = [];
      "Mod+Shift+P".action.power-off-monitors = [];
    };
  };
}
