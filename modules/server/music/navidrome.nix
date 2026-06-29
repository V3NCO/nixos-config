{ lib, config, pkgs, unstable, ... }:
let
  lyrics-navidrome = pkgs.buildNavidromePlugin rec {
    pname = "nd-lyrics";
    version = "6.1.3";

    src = pkgs.fetchFromGitHub {
      owner = "J0R6IT0";
      repo = "navidrome-lyrics-plugin";
      tag = "v${version}";
      hash = "sha256-dnl6TlRQYU6y7unzR8rDpuxOI9mxgo/PSrUVeBfiue4=";
    };

    vendorHash = "sha256-AAAAAlRQYU6y7unzR8rDpuxOI9mxgo/PSrUVeBfiue4";

    meta = {
      description = "A Navidrome plugin for fetching lyrics from various sources.";
      homepage = "https://github.com/J0R6IT0/navidrome-lyrics-plugin";
      sourceProvenance = with lib.sourceTypes; [ fromSource ];
    };
  };

  musixmatch-navidrome = pkgs.buildNavidromePlugin rec {
    pname = "navidrome-musixmatch-plugin";
    version = "0.2.1";

    src = pkgs.fetchFromGitHub {
      owner = "Myzel394";
      repo = "navidrome-musixmatch-plugin";
      tag = "v${version}";
      hash = "sha256-BBBBBlRQYU6y7unzR8rDpuxOI9mxgo/PSrUVeBfiue4";
    };

    vendorHash = "sha256-CCCCClRQYU6y7unzR8rDpuxOI9mxgo/PSrUVeBfiue4";

    meta = {
      description = "Scrape lyrics (plain & synced) from Musixmatch, the official lyrics provider for Spotify";
      homepage = "https://github.com/Myzel394/navidrome-musixmatch-plugin";
      sourceProvenance = with lib.sourceTypes; [ fromSource ];
    };
  };
in {
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
    package = unstable.navidrome;
    group = "music";
    environmentFile = "/var/lib/navidrome/.env";
    plugins = [
      unstable.navidromePlugins.listenbrainz-daily-playlist
      unstable.navidromePlugins.apple-music
      unstable.navidromePlugins.audiomuseai
      lyrics-navidrome
      musixmatch-navidrome
    ];
    settings = {
      Address = "127.0.0.1";
      EnableInsightsCollector = false;
      BaseUrl = "https://navidrome.v3nco.dev";
      MusicFolder = "/shared/music";
      DataFolder = "/var/lib/navidrome";
      LogFile = "/var/lib/navidrome/navidrome.log";
      EnableSharing = true;
      LyricsPriority = ".lrc,navidrome-musixmatch-plugin,nd-lyrics,.txt,embedded";
      Plugins = {
        Enabled = true;
        AutoReload = true;
      };
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
