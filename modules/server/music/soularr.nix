{ config, ... }:
{
  homelab = {
    ports = [ config.services.lidarr.settings.web.port config.services.slskd.settings.soulseek.listen_port ];
    services.slskd = {
      subdomain = "slskd";
      zone = "v3nco";
      upstream = {
        scheme = "http";
        host = "127.0.0.1";
        port = config.services.slskd.settings.web.port;
      };
      middlewares = [
        "security-headers"
      ];
    };
  };

  services.slskd = {
    enable = true;
    openFirewall = true;
    group = "music";
    environmentFile = "/var/lib/slskd/.env";
    settings = {
      directories = {
        incomplete = "/shared/downloads/incomplete/music";
        downloads = "/shared/downloads/music";
      };
      shares.directories = [
        "/shared/music"
      ];
      remote_file_management = true;
    };
    domain = null;
  };
}
