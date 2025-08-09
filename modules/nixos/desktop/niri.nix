{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    wl-clipboard # Clipboard support
    wayland-utils # Wayland debugging tools
    wev # Key event viewer (useful for finding key names)
    wlr-randr # Output management
    xwayland-satellite # X11 app support (non-native on niri)
    dragon-drop # Drag and drop support

    egl-wayland
    nvidia-vaapi-driver
    libvdpau-va-gl

    wl-mirror
    swaybg
    swww
    imagemagick
    swaylock
  ];

  boot.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
    "kvm-intel"
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    XDG_CURRENT_DESKTOP = "niri";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
  };

  programs.niri.enable = true;
  services.dbus.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
      open = true; # Use open kernel modules for Turing or later GPUs (RTX series)
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      powerManagement.enable = true; # Enable power management (suspend/resume)
    };

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