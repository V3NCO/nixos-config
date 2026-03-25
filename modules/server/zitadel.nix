{ config, ... }:
{
  homelab.ports = [ 8123 ];
  homelab.services.zitadel = {
    subdomain = "zitadel";
    zone = "v3nco";
    upstream = {
      scheme = "http";
      host = "127.0.0.1";
      port = config.services.zitadel.settings.Port;
    };
  };

  services.zitadel = {
    enable = true;
    tlsMode = "external";
    settings = {
      Port = 8123;
      ExternalDomain = "zitadel.v3nco.dev";
    };
  };
}
