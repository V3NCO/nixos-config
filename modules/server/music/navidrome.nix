{ config, lib, pkgs, unstable, ... }:
let
  lyrics-navidrome = pkgs.stdenv.mkDerivation {
    pname = "nd-lyrics";
    version = "8.0.0";

    src = pkgs.fetchurl {
      url = "https://github.com/J0R6IT0/navidrome-lyrics-plugin/releases/download/v8.0.0/nd-lyrics.ndp";
      hash = "sha256-7vfUje9U8LtlAzuBudaVkSxka34aYFjK3W1pvlBuUog=";
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/share
      cp $src $out/share/nd-lyrics.ndp
    '';

    passthru = { isNavidromePlugin = true; };
  };

  musixmatch-navidrome = pkgs.stdenv.mkDerivation {
    pname = "navidrome-musixmatch-plugin";
    version = "0.4.0";

    src = pkgs.fetchurl {
      url = "https://github.com/Myzel394/navidrome-musixmatch-plugin/releases/download/v0.4.0/navidrome-musixmatch-plugin.ndp";
      hash = "sha256-2w8sbpMKxx1SE3xWiU91QbkPn8Fx5CtBOvEM+okfLKI=";
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/share
      cp $src $out/share/navidrome-musixmatch-plugin.ndp
    '';

    passthru = { isNavidromePlugin = true; };
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
      unstable.navidromePlugins.audiomuseai
      lyrics-navidrome
      musixmatch-navidrome
    ];
    settings = {
      Address = "127.0.0.1";
      Agents = "audiomuseai,listenbrainz,lastfm,deezer";
      EnableInsightsCollector = false;
      BaseUrl = "https://navidrome.v3nco.dev";
      MusicFolder = "/shared/music";
      DataFolder = "/var/lib/navidrome";
      LogFile = "/var/lib/navidrome/navidrome.log";
      EnableSharing = true;
      LyricsPriority = ".lrc,nd-lyrics,navidrome-musixmatch-plugin,.txt,embedded";
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
