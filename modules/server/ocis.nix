{ config, ... }:
{
  homelab.services.ocis = {
    subdomain = "owncloud";
    zone = "v3nco";
    upstream = {
      scheme = "http";
      host = "127.0.0.1";
      port = config.services.ocis.port;
    };
    middlewares = [ "security-headers" ];
  };

  homelab.ports = [ config.services.ocis.port ];

  services.ocis = {
    enable = true;
    environmentFile = "/var/lib/ocis/.env";
    port = 8902;
    url = "https://owncloud.v3nco.dev";
  };
}
