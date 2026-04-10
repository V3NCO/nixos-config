{ ... }:
{
  services.syncthing = {
    enable = true;
    relay.enable = true;
    settings = {
      options = {
        urAccepted = -1;
      };
      folders = {
        "/home/venco/shared/sentinel" = {
          id = "sentinel-share";
          type = "sendreceive";
          copyOwnershipFromParent = true;
        };
      };
    };
  };
}
