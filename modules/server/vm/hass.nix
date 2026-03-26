{ ... }:
{
  homelab.services.hass = {
    subdomain = "ha";
    zone = "v3nco";
    upstream = {
      scheme = "http";
      host = "192.168.0.222";
      port = 8123;
    };
    middlewares = [ "security-headers" ];
  };
}
