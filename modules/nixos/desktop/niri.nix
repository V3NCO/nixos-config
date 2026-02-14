{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  environment.systemPackages = with pkgs; [
    wl-clipboard # Clipboard support
    wlr-randr # Output management
    xwayland-satellite # X11 app support (non-native on niri)
    dragon-drop # Drag and drop support
  ];

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = "gnome";
        "org.freedesktop.impl.portal.ScreenCast" = "gnome";
        "org.freedesktop.impl.portal.Screenshot" = "gnome";
        "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
      };
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-termfilechooser
    ];
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
}
