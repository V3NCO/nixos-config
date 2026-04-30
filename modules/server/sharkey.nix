{ config, ... }:
{
  homelab.services.sharkey = {
    subdomain = "sharkey";
    zone = "v3nco";
    upstream = {
      scheme = "http";
      host = "127.0.0.1";
      port = config.services.sharkey.settings.port;
    };
    middlewares = [ "security-headers" ];
  };

  homelab.ports = [ config.services.sharkey.settings.port ];

  services.sharkey = {
    enable = true;
    settings = {
      address = "127.0.0.1";
      url = "https://sharkey.v3nco.dev/";
    };
  };
}
