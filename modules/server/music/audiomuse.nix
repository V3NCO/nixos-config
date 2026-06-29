# Thanks to https://codeberg.org/oricat/nix-smf/src/branch/main/modules/services/audiomuse.nix :3
{ config, lib, ... }:

let
  audiomuseImage = "ghcr.io/neptunehub/audiomuse-ai:latest";
  dataDir = "/var/lib/audiomuse";
  redisServer = config.services.redis.servers.audiomuse;
  port = 8328;
in {
  homelab = {
    ports = [ port ];
    services.audiomuse = {
      subdomain = "audiomuse";
      zone = "v3nco";
      upstream = {
        scheme = "http";
        host = "127.0.0.1";
        port = port;
      };
      middlewares = [
        "security-headers"
      ];
    };
  };

  users.users.audiomuse = {
    isSystemUser = true;
    group = "audiomuse";
    uid = 970;
  };

  users.groups.audiomuse = {
    gid = 970;
  };

  systemd.tmpfiles.rules = [
    "d ${dataDir} 0755 audiomuse audiomuse -"
    "d ${dataDir}/temp_audio_flask 0755 audiomuse audiomuse -"
    "d ${dataDir}/temp_audio_worker 0755 audiomuse audiomuse -"
  ];

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "audiomuse" ];
    ensureUsers = [
      {
        name = "audiomuse";
        ensureDBOwnership = true;
        ensureClauses.login = true;
      }
    ];
  };

  services.redis.servers.audiomuse = {
    enable = true;
    settings = {
      maxmemory = "256mb";
      maxmemory-policy = "allkeys-lru";
    };
  };

  # AudioMuse Flask Web Application
  virtualisation.oci-containers.containers.audiomuse-flask = {
    image = audiomuseImage;
    autoStart = true;

    ports = [
      "${lib.toString port}:8000"
    ];

    environment = {
      SERVICE_TYPE = "flask";
      POSTGRES_USER="audiomuse";
      # Set POSTGRES_PASSWORD in env file;
      POSTGRES_DB="audiomuse";
      POSTGRES_HOST="/run/postgresql";
      POSTGRES_PORT="5432";
      REDIS_URL="unix://${redisServer.unixSocket}";
      TZ="Europe/Paris";
      TEMP_DIR="${dataDir}/temp_audio";
    };

    environmentFiles = [
      "${dataDir}/.env"
    ];

    volumes = [
      "${dataDir}/temp_audio_flask:/app/temp_audio:Z"
    ];

    dependsOn = [ ];

    extraOptions = [
      "--network=host"
      "--user=970:970"
    ];
  };

  # AudioMuse RQ Worker
  virtualisation.oci-containers.containers.audiomuse-worker = {
    image = audiomuseImage;
    autoStart = true;

    environment = {
      SERVICE_TYPE = "worker";
      POSTGRES_USER="audiomuse";
      # Set POSTGRES_PASSWORD in env file;
      POSTGRES_DB="audiomuse";
      POSTGRES_HOST="/run/postgresql";
      POSTGRES_PORT="5432";
      REDIS_URL="unix://${redisServer.unixSocket}";
      TZ="Europe/Paris";
      TEMP_DIR="${dataDir}/temp_audio";
    };

    environmentFiles = [
      "${dataDir}/.env"
    ];

    volumes = [
      "${dataDir}/temp_audio_worker:/app/temp_audio:Z"
    ];

    dependsOn = [ ];

    extraOptions = [
      "--network=host"
      "--user=970:970"
    ];
  };

  systemd.services."podman-audiomuse-flask" = {
    requires = [ "postgresql.service" "redis-audiomuse.service" ];
    after = [ "postgresql.service" "redis-audiomuse.service" ];
  };

  systemd.services."podman-audiomuse-worker" = {
    requires = [ "postgresql.service" "redis-audiomuse.service" ];
    after = [ "postgresql.service" "redis-audiomuse.service" ];
  };
}
