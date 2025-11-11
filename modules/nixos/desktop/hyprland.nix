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
      pkgs.hyprlandPlugins.hyprscrolling
      pkgs.hyprlandPlugins.hyprspace
      pkgs.hyprlandPlugins.hyprgrass # Touch grass :p
    ];
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, T, exec, kitty"
        "$mod, L, exit"
      ];
      input = {
        kb_layout = "fr";
        numlock_by_default = true;
        repeat_delay = 250;
        repeat_rate = 35;
        follow_mouse = 1;
        off_window_axis_events = 2;

      };
    };
  };
}
