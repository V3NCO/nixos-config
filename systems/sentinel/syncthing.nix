{ ... }:
{
  users.users.syncthing.group = "music";

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
          devices = ["quasar"];
        };
      };
    };
  };
}
