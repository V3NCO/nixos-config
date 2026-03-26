{ config, ... }:
{
  homelab = {
    ports = [];
    services = {
      paperless-ngx = {
        subdomain = "paperless";
        zone = "v3nco";
        upstream = {
          scheme = "http";
          host = "127.0.0.1";
          port = config.services.paperless.port;
        };
      };
    };
  };

  services.paperless = {
    enable = true;
    configureTika = true;
    domain = "paperless.v3nco.dev";
    environmentFile = "/var/lib/paperless/.env";
    exporter = {
      enable = true;
    };
  };
}
