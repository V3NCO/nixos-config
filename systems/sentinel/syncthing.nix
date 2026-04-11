{ ... }:
{
  users.users.syncthing.group = "music";

  services.syncthing = {
    enable = true;
    relay.enable = true;
    group = "music";
    settings = {
      options = {
        relaysEnabled = true;
        urAccepted = -1;
      };
      devices = {
        "quasar" = {
          name = "quasar";
          id = "LMPIBFE-3QVLUXS-OCRLMVA-RG7MAUI-HOBLUHS-YMN2QRP-NDBNEES-RIEVEAE";
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
