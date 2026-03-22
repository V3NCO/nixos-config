{ config, ... }:
{
  homelab.services.vaultwarden = {
    subdomain = "vaultwarden";
    zone = "v3nco";
    upstream = {
      scheme = "http";
      host = "127.0.0.1";
      port = config.services.vaultwarden.config.ROCKET_PORT;
    };
    middlewares = [ "security-headers" ];
  };

  homelab.ports = [ config.services.vaultwarden.config.ROCKET_PORT ];
  services.vaultwarden = {
    enable = true;
    backupDir = "/var/local/vaultwarden/backup";
    config = {
      DOMAIN = "https://vaultwarden.v3nco.dev";
      SIGNUPS_ALLOWED = false;
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      ROCKET_LOG = "critical";
    };
  };
}
