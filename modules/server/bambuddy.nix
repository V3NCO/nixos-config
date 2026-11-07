{ config, lib, pkgs, ... }:

let
  webImage = "ghcr.io/gabe565/obico/web:latest";
  mlApiImage = "ghcr.io/gabe565/obico/ml-api:latest";
  dataDir = "/var/lib/obico";
  port = 3334;
  mlPort = 3333;

  obicoSrc = pkgs.fetchFromGitHub {
    owner = "gabe565";
    repo = "obico-server";
    rev = "df8190ef7500459599ebf398c3d1f653754792fd";
    hash = "sha256-Zic4evehylXQIQZZ5+yMhQshAxCfsD6r741PEstyz44=";
  };
in {
  homelab = {
    ports = [ port ];
    services.obico = {
      subdomain = "obico";
      zone = "v3nco";
      upstream = { scheme = "http"; host = "127.0.0.1"; port = port; };
      middlewares = [ "security-headers" ];
    };
  };

  users.users.obico = {
    isSystemUser = true;
    group = "obico";
    uid = 975;
  };
  users.groups.obico.gid = 975;

  systemd.tmpfiles.rules = [
    "d ${dataDir} 0755 obico obico -"
    "d ${dataDir}/media 0755 obico obico -"
  ];

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "obico" ];
    ensureUsers = [{
      name = "obico";
      ensureDBOwnership = true;
      ensureClauses = { login = true; createrole = true; };
    }];
    authentication = "host all obico 127.0.0.1/32 scram-sha-256";
  };

  services.redis.servers.obico = {
    enable = true;
    port = 6379;
    bind = "127.0.0.1";
    settings = { maxmemory = "256mb"; maxmemory-policy = "allkeys-lru"; };
  };

  systemd.services."podman-build-obico-intel" = {
    description = "Build Obico Intel OpenVINO ML Image";
    wantedBy = [ "multi-user.target" ];
    before = [ "podman-obico-ml.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      if ! podman image exists obico-ml-intel:latest; then
        echo "Building Obico Intel OpenVINO image..."
        podman build -f ${obicoSrc}/ml_api/Dockerfile.intel -t obico-ml-intel:latest ${obicoSrc}/ml_api/
      fi
    '';
  };

  virtualisation.oci-containers.containers.obico-web = {
    image = webImage;
    autoStart = true;
    environmentFiles = [ "${dataDir}/.env" ];
    environment = {
      DATABASE_URL = "postgres://obico@127.0.0.1:5432/obico";
      REDIS_URL = "redis://127.0.0.1:6379/0";
      INTERNAL_MEDIA_HOST = "http://127.0.0.1:${toString port}";
      ML_API_HOST = "http://127.0.0.1:${toString mlPort}";
      SITE_USES_HTTPS = "True";
    };
    volumes = [ "${dataDir}/media:/app/media:Z" ];
    extraOptions = [ "--network=host" "--user=975:975" ];
  };

  virtualisation.oci-containers.containers.obico-ml = {
    image = "obico-ml-intel:latest";
    autoStart = true;
    environmentFiles = [ "${dataDir}/.env" ];
    environment = {
      REDIS_URL = "redis://127.0.0.1:6379/0";
      ML_API_GPU_PROVIDER = "OpenVINOExecutionProvider";
      ML_API_OPENVINO_DEVICE = "GPU";
    };
    devices = [ "/dev/dri:/dev/dri" ];
    extraOptions = [
      "--network=host"
      "--user=975:975"
      "--device=card0"
      "--device=renderD128"
    ];
  };

  virtualisation.oci-containers.containers.obico-tasks = {
    image = webImage;
    autoStart = true;
    environmentFiles = [ "${dataDir}/.env" ];
    environment = {
      DATABASE_URL = "postgres://obico@127.0.0.1:5432/obico";
      REDIS_URL = "redis://127.0.0.1:6379/0";
      INTERNAL_MEDIA_HOST = "http://127.0.0.1:${toString port}";
      ML_API_HOST = "http://127.0.0.1:${toString mlPort}";
    };
    cmd = [ "sh" "-c" "celery -A config worker --beat -l info -c 2 -Q realtime,celery" ];
    extraOptions = [ "--network=host" "--user=975:975" ];
  };

  systemd.services."podman-obico-web".after = [ "postgresql.service" "redis-obico.service" ];
  systemd.services."podman-obico-ml".after = [ "redis-obico.service" "podman-build-obico-intel.service" ];
  systemd.services."podman-obico-tasks".after = [ "postgresql.service" "redis-obico.service" "podman-obico-web.service" ];
}
