{ inputs, pkgs, ... }:
# let
#   pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
# in
{
  imports = [ inputs.hyprland.nixosModules.default ];

  #hardware.graphics = {
  #  package = pkgs-unstable.mesa;

  # if you also want 32-bit support (e.g for Steam)
  #  enable32Bit = true;
  #  package32 = pkgs-unstable.pkgsi686Linux.mesa;
  #};

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

      bind = [
        "$mod, SPACE, global, caelestia:launcher"
        "$mod, RETURN, exec, kitty"
        "$mod, Q, killactive"
        "$mod, L, exit"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod SHIFT, mouse_up, layoutmsg, move +col"
        "$mod SHIFT, mouse_down, layoutmsg, move -col"
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
        ", XF86AudioRaiseVolume, exec, vol --up"
        ", XF86AudioLowerVolume, exec, vol --down"
        ", XF86MonBrightnessUp, exec, bri --up"
        ", XF86MonBrightnessDown, exec, bri --down"
        ", XF86Search, exec, launchpad"
      ];

      input = {
        kb_layout = "fr";
        numlock_by_default = true;
        repeat_delay = 250;
        repeat_rate = 35;
        follow_mouse = 1;
        off_window_axis_events = 2;
      };

      exec-once = [
        "gnome-keyring-daemon --start --components=secrets"
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
        "clipse -listen"
        "caelestia shell -d"
      ];

      plugin = {
        hyprscrolling = {
          column_width = 0.9;
          fullscreen_on_one_column = false;
          follow_focus = false;
          focus_fit_method = 1;
        };
      };

    };
  };
}
