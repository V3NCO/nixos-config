{ pkgs, lib, config, ... }:

let
  wrtag = (pkgs.buildGoModule (finalAttrs: {
    pname = "wrtag";
    version = "0.30.0";

    src = pkgs.fetchFromGitHub {
      owner = "sentriz";
      repo = "wrtag";
      tag = "v${finalAttrs.version}";
      hash = "sha256-ba3HrAUaI9onuRFns9q2fkJxZWhadqJjd8rAmlIVvg4=";
    };

    vendorHash = "sha256-CevWYD93fdt7MmWZjBKGR3+isOzWzAo5c8X55qG8/2A=";

    nativeBuildInputs = [ pkgs.installShellFiles ];

    postInstall = ''
      installShellCompletion contrib/completions/wrtag.{fish,bash}
      installShellCompletion contrib/completions/metadata.fish
    '';

    passthru = {
      updateScript = pkgs.nix-update-script { };
      tests.version = testers.testVersion {
        package = finalAttrs.finalPackage;
        command = "wrtag --version";
      };
    };
  }))
in
{
  # Just go in the git history for the beets config ngl

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

      wrtag = {
        subdomain = "wrtag";
        zone = "v3nco";
        upstream = {
          scheme = "http";
          host = "127.0.0.1";
          port = 7834;
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
    wrtag
  ];


  systemd.services."wrtag-web" = {
    serviceConfig = {
      ExecStart = ''
        ${lib.getExe wrtag "wrtagweb"} -addon "lyrics lrclib musixmatch genius" -addon "replaygain"
      '';
      User = "wrtag";
      Group = "music";
      environmentFile = "/var/lib/wrtag/.env";
      environment = {
        WRTAG_WEB_DB_PATH = "/var/lib/wrtag/wrtag.db";
        WRTAG_WEB_LISTEN_ADDR = ":7834";
        WRTAG_WEB_PUBLIC_URL="https://wrtag.v3nco.dev";
        WRTAG_PATH_FORMAT="/shared/music/{{ artists .Release.Artists | sort | join "; " | safepath }}/({{ .Release.ReleaseGroup.FirstReleaseDate.Year }}) {{ .Release.Title | safepath }}{{ if not (eq .ReleaseDisambiguation "") }} ({{ .ReleaseDisambiguation | safepath }}){{ end }}/{{ if gt (len .Release.Media) 1 }}d{{ pad0 2 .Media.Position }} {{ end }}{{ pad0 2 .Track.Position }}.{{ .Media.TrackCount | pad0 2 }} {{ if .IsCompilation }}{{ artistsString .Track.Artists | safepath }} - {{ end }}{{ .Track.Title | safepath }}{{ .Ext }}"
      };
    };
  };

  users.groups.music = {};
  users.users.wrtag.group = "music";

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
