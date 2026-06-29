{ pkgs, config, ... }:
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

  homelab.ports = [ config.services.ollama.port ];
  homelab.services = {
    ollama = {
      subdomain = "ollama";
      zone = "v3nco";
      upstream = {
        scheme = "http";
        host = "127.0.0.1";
        port = config.services.ollama.port;
      };
    };
  };

  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    loadModels = [
      "qwen3:14b"
      "ornith:35b"
      "deepseek-r1:14b"
      "qwen2.5:32b-q3_K_M"
      "qwen2.5-coder:7b"
      "nomic-embed-text"
    ];
  };
}
