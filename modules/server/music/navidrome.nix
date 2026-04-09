{ config, ... }:
{
  homelab = {
    ports = [ config.services.navidrome.settings.Port ];
    services.navidrome = {
      subdomain = "navidrome";
      zone = "v3nco";
      upstream = {
        scheme = "http";
        host = "127.0.0.1";
        port = config.services.navidrome.settings.Port;
      };
      middlewares = [
        "security-headers"
      ];
    };
  };


  services.navidrome = {
    enable = true;
    group = "music";
    environmentFile = "/var/lib/navidrome/.env";
    settings = {
      Address = "127.0.0.1";
      EnableInsightsCollector = false;
      BaseUrl = "https://navidrome.v3nco.dev";
      MusicFolder = "/shared/music";
      DataFolder = "/var/lib/navidrome";
      LogFile = "/var/lib/navidrome/navidrome.log";
    };
  };

  systemd.services.navidrome.serviceConfig = {
    BindReadOnlyPaths = [
      "/shared/music"
    ];
  };

  users.groups.music = {};
  users.users.navidrome.group = "music";
}
