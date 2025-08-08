{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    wl-clipboard # Clipboard support
    wayland-utils # Wayland debugging tools
    wev # Key event viewer (useful for finding key names)
    wlr-randr # Output management
    xwayland-satellite # X11 app support (non-native on niri)
    dragon-drop # Drag and drop support

    wl-mirror
    swaybg
    swww
    imagemagick
    swaylock
  ];


  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_CURRENT_DESKTOP = "niri";
    
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
  };

  programs.niri.enable = true;
  services.dbus.enable = true;

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
}