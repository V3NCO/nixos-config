{ inputs, config, ... }:
{
  imports = ["${inputs.nixpkgs-unstable}/nixos/modules/services/security/tinyauth.nix"];

  homelab.ports = [ 4390 4391 ];
  homelab.services = {
    tinyauth = {
      subdomain = "tinyauth";
      zone = "v3nco";
      upstream = {
        scheme = "http";
        host = "127.0.0.1";
        port = config.services.tinyauth.settings.SERVER_PORT;
      };
    };
    pocketid = {
      subdomain = "pid";
      zone = "v3nco";
      upstream = {
        scheme = "http";
        host = "127.0.0.1";
        port = config.services.pocket-id.settings.PORT;
      };
    };
  };

  services.tinyauth = {
    enable = true;
    settings = {
      APPURL = "https://tinyauth.v3nco.dev";
      SERVER_PORT = 4390;
      SERVER_ADDRESS = "127.0.0.1";
    };
  };
  services.pocket-id = {
    enable = true;
    settings = {
      ANALYTICS_DISABLED = true;
      HOST = "127.0.0.1";
      PORT = 4391;
    };
  };
}
