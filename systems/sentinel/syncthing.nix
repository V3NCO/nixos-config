{ ... }:
{
  services.syncthing = {
    enable = true;
    relay.enable = true;
    user = "root";
    group = "root";
    settings = {
      options = {
        relaysEnabled = true;
        urAccepted = -1;
      };
      devices = {
      };
      folders = {
        "/shared" = {
          id = "sentinel-share";
          type = "sendreceive";
          copyOwnershipFromParent = true;
        };
      };
    };
  };
}
