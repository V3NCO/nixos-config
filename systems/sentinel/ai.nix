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

  homelab.ports = [ config.services.ollama.port config.services.open-webui.port ];
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
    open-webui = {
      subdomain = "ai";
      zone = "v3nco";
      upstream = {
        scheme = "http";
        host = "127.0.0.1";
        port = config.services.open-webui.port;
      };
    };
  };

  services.ollama = {
    enable = true;
    host = "0.0.0.0";
    package = unstable.ollama-vulkan;
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

  services.open-webui = {
    enable = true;
    port = 38924;
    host = "0.0.0.0";
    environmentFile="/var/lib/open-webui/.env";
    environment = {
      WEBUI_URL = "https://ai.v3nco.dev";
      ENABLE_SIGNUP = "False";
      ENABLE_LOGIN_FORM = "False";
      ENABLE_PASSWORD_AUTH = "False";
      ENABLE_CHANNELS = "True";
      ENABLE_USER_WEBHOOKS = "True";
      WEBUI_NAME = "Sentinel Chat";
      ENABLE_CHAT_RESPONSE_BASE64_IMAGE_URL_CONVERSION = "True";
      ENABLE_OLLAMA_API = "True";
      OLLAMA_BASE_URL = "http://localhost:11434";
      ENABLE_OPENAI_API = "False";
      ENABLE_WEB_SEARCH = "True";
      WEB_SEARCH_ENGINE = "searxng";
      AUDIO_TTS_ENGINE="transformers";
      ENABLE_OAUTH_SIGNUP = "True";
      ENABLE_OAUTH_BACKCHANNEL_LOGOUT = "True";
      OAUTH_CLIENT_ID = "5cd8131d-a540-43b5-bfec-36934fc7ad23";
      OPENID_PROVIDER_URL = "https://pid.v3nco.dev/.well-known/openid-configuration";
      OPENID_REDIRECT_URI = "https://ai.v3nco.dev/oauth/oidc/callback";
      OAUTH_PROVIDER_NAME = "Pocket ID";
    };
  };
}
