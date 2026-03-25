{ pkgs, inputs, config, ... }:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
  };
in {
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
    package = unstable.tinyauth ;
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
      TRUST_PROXY = true;
      APP_URL = "https://pid.v3nco.dev";
      HOST = "127.0.0.1";
      PORT = 4391;
    };
  };
}
