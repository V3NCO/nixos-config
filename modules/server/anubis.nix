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
      nexus = {
        settings = {
          TARGET = "https://100.93.234.76";
        };
      };
      forgejo = {
        settings = {
          TARGET = "https://100.93.234.76";
        };
      };
    };
  };
}
