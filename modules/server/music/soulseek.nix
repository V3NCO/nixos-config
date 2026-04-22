{ pkgs, lib, config, ... }:

let
  customBeets = (pkgs.python313Packages.beets.override {
    pluginOverrides = {
      beetcamp = {
        enable = true;
        propagatedBuildInputs = [ pkgs.python313Packages.beetcamp ];
      };
      youtube = {
        enable = true;
        propagatedBuildInputs = [
          (pkgs.python313Packages.buildPythonPackage rec {
            pname = "beets-youtube";
            version = "0.1.0";
            src = pkgs.fetchFromGitHub {
              owner = "arsaboo";
              repo = "beets-youtube";
              rev = "85503871a901c24220214c66ce22ac191eb0417c";
              hash = "sha256-n5wssgsNZOXNcX2fhORPtCozIqTUSXHfL0EQ8gbsN3k=";
            };
            format = "setuptools";
            propagatedBuildInputs = with pkgs.python313Packages; [
              ytmusicapi
              requests
              pillow
            ];
          })
        ];
      };
    };
  }).overridePythonAttrs (old: {
    catchConflicts = false;
  });

in
{
  homelab = {
    ports = [ config.services.slskd.settings.web.port config.services.slskd.settings.soulseek.listen_port 7834 ];
    services ={
      slskd = {
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
  };

  environment.systemPackages = [
    customBeets
    pkgs.ffmpeg
    pkgs.chromaprint
  ];


  systemd.timers."beets-import-soulseek" = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "15m";
        OnUnitActiveSec = "15m";
        Unit = "beets-import-soulseek.service";
      };
    };

    systemd.services."beets-import-soulseek" = {
      script = "set -eu && ${lib.getExe customBeets} import /shared/downloads/music --quiet";
      serviceConfig = {
        Type = "oneshot";
        User = "root";
      };
    };

  users.groups.music = {};
  users.users.wrtag = { group = "music"; isSystemUser = true; };

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
      shares.filters = [
        ".*Yowane.*"
        ".*Vylet Pony.*"
        ".*Gonarch's Lair.*"
      ];
      remote_file_management = true;
    };
    domain = null;
  };
}
