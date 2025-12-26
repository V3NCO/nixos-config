{ ... }:
{
  services.anubis = {
    defaultOptions = {
      settings = {
        WEBMASTER_EMAIL = "anubis@v3nco.dev";
        SERVE_ROBOTS_TXT = true;
      };
    };
    instances = {
      traefik = {
        settings = {
          BIND = ":7980";
          REDIRECT_DOMAINS = "v3nco.dev";
          PUBLIC_URL = "https://anubis.v3nco.dev";
          #METRICS_BIND = "/run/anubis/anubis-forgejo/metrics.sock";
          TARGET = " ";
          COOKIE_DOMAIN = "v3nco.dev";
        };
      };
    };
  };

  users.groups.anubis = { };

  systemd.services.traefik.serviceConfig = {
    SupplementaryGroups = "anubis";
  };

  systemd.tmpfiles.rules = [
    "d /run/anubis 0755 root anubis -"
    "d /run/anubis/anubis-nexus 0755 root anubis -"
    "d /run/anubis/anubis-forgejo 0755 root anubis -"
  ];
}
