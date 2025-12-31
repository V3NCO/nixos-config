{ inputs, pkgs, ... }:
{
  imports = [ inputs.hyprland.nixosModules.default ];

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "hyprland";
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
      inputs.hyprgrass.packages.${pkgs.stdenv.hostPlatform.system}.default # Touch grass :p
    ];
    settings = {
      "$mod" = "SUPER";
      exec = [ "hyprctl dispatch submap global" ];
      submap = "global";
      general.layout = "scrolling";
      cursor.no_hardware_cursors = true;

      windowrulev2 = [
        "noinitialfocus, class:(jetbrains-)(.*), floating:0"
        "noinitialfocus, class:(jetbrains-)(.*), title:^$, initialTitle:^$, floating:0"
        "center, class:(jetbrains-)(.*), initialTitle:(.+), floating:0"
        "center, class:(jetbrains-)(.*), title:^$, initialTitle:^$, floating:0"
        "noinitialfocus, class:(jetbrains-) (.*), title:^win(.*), initialTitle:win.*, floating:0"
      ];

      bind = [
        "$mod, SPACE, global, caelestia:launcher"
        "$mod, RETURN, exec, kitty"
        "$mod, Q, killactive"
        "$mod SHIFT, L, exit"
        "$mod, L, global, caelestia:lock"
        " , Print, exec, hyprshot -m region -z --raw | swappy -f -"
        "$mod SHIFT, 4, exec, hyprshot -m region -z --raw | swappy -f -"
        "$mod, left, layoutmsg, focus l"
        "$mod, right, layoutmsg, focus r"
        "$mod, up, layoutmsg, focus u"
        "$mod, down, layoutmsg, focus d"

        "$mod SHIFT, mouse_up, layoutmsg, focus r"
        "$mod SHIFT, mouse_down, layoutmsg, focus l"
        "$mod, J, layoutmsg, promote"
        "$mod, K, layoutmsg, fit active"

        ",swipe:3:r,layoutmsg,focus r"
        ",swipe:3:l,layoutmsg,focus l"
        ",swipe:3:u,layoutmsg,focus u"
        ",swipe:3:d,layoutmsg,focus d"
        ",swipe:4:u,exec,caelestia-launcher"
        ",swipe:4:d,killactive"
      ];
      binde = [
        "$mod, parenright, splitratio, -0.1"
        "$mod, Equal, splitratio, 0.1"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, X, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod, X, resizewindow"
      ];
      bindin = [
        "$mod, catchall, global, caelestia:launcherInterrupt"
        "$mod, mouse:272, global, caelestia:launcherInterrupt"
        "$mod, mouse:273, global, caelestia:launcherInterrupt"
        "$mod, mouse:274, global, caelestia:launcherInterrupt"
        "$mod, mouse:275, global, caelestia:launcherInterrupt"
        "$mod, mouse:276, global, caelestia:launcherInterrupt"
        "$mod, mouse:277, global, caelestia:launcherInterrupt"
        "$mod, mouse_up, global, caelestia:launcherInterrupt"
        "$mod, mouse_down, global, caelestia:launcherInterrupt"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
      bindle = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 3%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 3%-"
        ", XF86MonBrightnessUp, global, caelestia:brightnessUp"
        ", XF86MonBrightnessDown, global, caelestia:brightnessDown"
        ", XF86Search, exec, launchpad"
      ];

      input = {
        kb_layout = "us";
        numlock_by_default = true;
        repeat_delay = 250;
        repeat_rate = 35;
        follow_mouse = 1;
        off_window_axis_events = 2;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          tap-to-click = true;
          drag_lock = false;
          clickfinger_behavior = true;
        };
      };

      exec-once = [
        "gnome-keyring-daemon --start --components=secrets"
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
        "clipse -listen"
        "caelestia shell -d"
        "libinput-gestures"
      ];

      plugin = {
        hyprscrolling = {
          column_width = 0.9;
          fullscreen_on_one_column = false;
          follow_focus = false;
          focus_fit_method = 0;
        };
        touch_gestures = {
          sensitivity = 1.0;
          workspace_swipe_fingers = 3;
          long_press_delay = 400;

          experimental = {
            send_cancel = 0;
          };
        };
      };
    };
  };
}
