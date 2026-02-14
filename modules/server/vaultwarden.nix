{ config, ... }:
{
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
}
