{ lib, ... }:
{
  services.anubis = {
    defaultOptions = {
      settings = {
        WEBMASTER_EMAIL = "anubis@v3nco.dev";
        SERVE_ROBOTS_TXT = true;
      };
    };
    instances = {
      nexus = {
        settings = {
          BIND = "/run/anubis/anubis-nexus/anubis.sock";
          METRICS_BIND = "/run/anubis/anubis-nexus/metrics.sock";
          TARGET = "https://100.93.234.76";
        };
      };
      forgejo = {
        settings = {
          BIND = "/run/anubis/anubis-forgejo/anubis.sock";
          METRICS_BIND = "/run/anubis/anubis-forgejo/metrics.sock";
          TARGET = "https://100.93.234.76";
        };
      };
    };
  };

  users.groups.anubis = { };

  users.users.nginx.extraGroups = lib.mkDefault [ "anubis" ];

  systemd.tmpfiles.rules = [
    "d /run/anubis 0755 root anubis -"
    "d /run/anubis/anubis-nexus 0755 root anubis -"
    "d /run/anubis/anubis-forgejo 0755 root anubis -"
  ];
}
