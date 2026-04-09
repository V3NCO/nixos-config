{ config, ... }:
{
  homelab = {
    ports = [ config.services.lidarr.settings.server.port ];
    services.lidarr = {
      subdomain = "lidarr";
      zone = "v3nco";
      upstream = {
        scheme = "http";
        host = "127.0.0.1";
        port = config.services.lidarr.settings.server.port;
      };
      middlewares = [
        "security-headers"
      ];
    };
  };

  services.lidarr = {
    enable = true;
    group = "music";
    settings = {
      server = {
        port = 8686;
      };
    };
  };

  users.groups.music = {};
  users.users.lidarr.group = "music";
}
