{ ... }:
{
  services.syncthing = {
    enable = true;
    relay.enable = true;
    user = "venco";
    settings = {
      options = {
        urAccepted = -1;
      };
      devices = {
        "sentinel" = {
          name = "sentinel";
          id = "M2ZZDVQ-SVNYCBE-Z4GJMDA-7LIGHPH-7ARIDQR-CZWO4YC-QRSKEMV-TMZMIAU";
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
