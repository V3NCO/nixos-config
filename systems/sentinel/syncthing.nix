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
          id = "ELTGVOH-WX2MMU6-LGXOMFR-TCB7ROU-EWZBTWM-STXGNWL-BEAKGYI-ERUNBQD";
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
