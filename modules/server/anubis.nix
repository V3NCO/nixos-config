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
          BIND_NETWORK = "tcp";
          BIND = ":7980";
          REDIRECT_DOMAINS = "v3nco.dev,nexus.v3nco.dev,forgejo.v3nco.dev";
          PUBLIC_URL = "https://anubis.v3nco.dev";
          METRICS_BIND_NETWORK = "tcp";
          METRICS_BIND = "127.0.0.1:9099";
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
    "d /run/anubis/anubis-traefik 0755 root anubis -"
    "d /run/anubis/anubis-nexus 0755 root anubis -"
    "d /run/anubis/anubis-forgejo 0755 root anubis -"
  ];
}
