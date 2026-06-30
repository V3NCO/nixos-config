{ pkgs, unstable, config, ... }:
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
    ANV_ENABLE_PIPELINE_CACHE = "1";
  };

  hardware.enableRedistributableFirmware = true;

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
    package = unstable.ollama-vulkan;$
    environmentVariables = {
      OLLAMA_NUM_PARALLEL = "1";
    };
    loadModels = [
      "qwen3.5:35b-a3b"
      "gemma4:26b"
      "ornith:35b"
      "deepseek-r1:32b"
      "devstral:24b"
      "gpt-oss:20b"
      "nomic-embed-text"
      "llama3.2:3b"
      "gemma4:e4b"
      "qwen3.5:9b"
    ];
    syncModels = true;
  };
}
