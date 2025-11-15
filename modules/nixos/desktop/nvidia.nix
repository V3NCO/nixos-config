{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    wayland-utils # Wayland debugging tools
    wev # Key event viewer (useful for finding key names)
    egl-wayland
    nvidia-vaapi-driver
    libvdpau-va-gl
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
    # ELECTRON_OZONE_PLATFORM_HINT = "auto";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  services.dbus.enable = true;

  hardware.nvidia = {
    open = true; # Use open kernel modules for Turing or later GPUs (RTX series)
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = true; # Enable power management (suspend/resume)
  };
}
