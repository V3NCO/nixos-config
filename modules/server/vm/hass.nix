{ ... }:
{
  homelab.services.hass = {
    subdomain = "ha";
    zone = "v3nco";
    upstream = {
      scheme = "http";
      host = "100.110.203.27";
      port = 8123;
    };
    middlewares = [ "security-headers" ];
  };
}
