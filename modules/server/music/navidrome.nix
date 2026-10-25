{ config, lib, unstable, ... }:
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
    package = unstable.navidrome.withPlugins (p: [
      p.audiomuseai
      p.listenbrainz-daily-playlist
      p.lyrics-plugin
    ]);
    group = "music";
    environmentFile = "/var/lib/navidrome/.env";
    settings = {
      Address = "127.0.0.1";
      Agents = "audiomuseai,listenbrainz,lastfm,deezer";
      EnableInsightsCollector = false;
      BaseUrl = "https://navidrome.v3nco.dev";
      MusicFolder = "/shared/music";
      DataFolder = "/var/lib/navidrome";
      LogFile = "/var/lib/navidrome/navidrome.log";
      EnableSharing = true;
      LyricsPriority = ".ttml,.elrc,.lrc,nd-lyrics,.txt,embedded";
      Plugins = {
        Enabled = true;
        AutoReload = true;
      };
    };
  };

  systemd.services.navidrome.serviceConfig = {
    RootDirectory = lib.mkForce "";

    BindReadOnlyPaths = lib.mkForce [ "" ];

    ReadWritePaths = [
      "/shared"
      "/shared/music"
      "/shared/vocaloid"
    ];
  };

  users.groups.music = {};
  users.users.navidrome.group = "music";
}
