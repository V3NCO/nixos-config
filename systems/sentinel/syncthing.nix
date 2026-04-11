{ config, ... }:
{
  users.users.syncthing.group = "music";

  homelab = {
    ports = [ 8384 22000 21027 ];
    services ={
      syncthing = {
        subdomain = "syncthing";
        zone = "v3nco";
        upstream = {
          scheme = "http";
          host = "127.0.0.1";
          port = 8384;
        };
        middlewares = [
          "security-headers"
          "tinyauth"
        ];
      };
    };
  };

  services.syncthing = {
    enable = true;
    relay.enable = true;
    group = "music";
    dataDir = "/shared";
    configDir = "/var/lib/syncthing/.config/syncthing";
    key = "/var/lib/syncthing/key.pem";
    cert = "/var/lib/syncthing/cert.pem";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      gui.insecureSkipHostcheck = true;
      options = {
        relaysEnabled = true;
        urAccepted = -1;
      };
      devices = {
        "quasar" = {
          name = "quasar";
          id = "3K6DWLC-GP2KH6Z-JHTU2E2-KLKZJEP-CZ24AN7-F26IYOX-LEMNPCS-73P5NAT";
        };
      };
      folders = {
        "/shared" = {
          id = "sentinel-share";
          type = "sendreceive";
          ignorePerms = true;
          devices = ["quasar"];
        };
      };
    };
  };
}
