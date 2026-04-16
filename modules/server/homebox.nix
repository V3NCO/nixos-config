{ config, lib, ... }:
{
  homelab.services.homebox = {
    subdomain = "homebox";
    zone = "v3nco";
    upstream = {
      scheme = "http";
      host = "127.0.0.1";
      port = (lib.toInt config.services.homebox.settings.HBOX_WEB_PORT);
    };
    middlewares = [ "security-headers" ];
  };

  homelab.ports = [ (lib.toInt config.services.homebox.settings.HBOX_WEB_PORT) ];

  services.homebox = {
    enable = true;
    database.createLocally = true;
    settings = {
      HBOX_WEB_PORT = "7745";
      HBOX_STORAGE_CONN_STRING = "file:///var/lib/homebox";
      HBOX_STORAGE_PREFIX_PATH = "data";
      HBOX_OPTIONS_ALLOW_REGISTRATION = "false";
      HBOX_OPTIONS_CHECK_GITHUB_RELEASE = "false";
      HBOX_MODE = "production";
      HOME = "/var/lib/homebox";
      TMPDIR = "/var/lib/homebox/tmp";
    };
  };

}
