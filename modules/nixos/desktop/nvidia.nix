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
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    # ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  services.dbus.enable = true;

  hardware.nvidia = {
    open = true; # Use open kernel modules for Turing or later GPUs (RTX series)
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = true; # Enable power management (suspend/resume)
  };
}
