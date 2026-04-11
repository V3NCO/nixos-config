{ ... }:
{
  services.syncthing = {
    enable = true;
    relay.enable = true;
    user = "venco";
    dataDir = "/home/venco/shared";
    configDir = "/var/lib/syncthing/.config/syncthing";
    key = "/var/lib/syncthing/key.pem";
    cert = "/var/lib/syncthing/cert.pem";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      options = {
        urAccepted = -1;
      };
      devices = {
        "sentinel" = {
          name = "sentinel";
          id = "7PWDSHB-KQE65KX-DC3ZHGM-ZIRW27E-YN432QL-POGZ3BM-PNYJU2W-KOI3EQJ";
        };
      };
      folders = {
        "/home/venco/shared/sentinel" = {
          id = "sentinel-share";
          type = "sendreceive";
          copyOwnershipFromParent = true;
          devices = ["sentinel"];
        };
      };
    };
  };
}
