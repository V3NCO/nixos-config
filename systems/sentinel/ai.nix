{ pkgs, ... }:
{
  hardware.cpu.intel.npu.enable = true;

  services.xserver.videoDrivers = [ "modesetting" ];

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt

        intel-compute-runtime  # OpenCL (NEO) + Level Zero for Arc/Xe
        # libvdpau-va-gl       # Only if you must run VDPAU-only apps
      ];
    };

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
      # VDPAU_DRIVER = "va_gl";      # Only if using libvdpau-va-gl
    };

    hardware.enableRedistributableFirmware = true;
    boot.kernelParams = [ "i915.enable_guc=3" ];
}
