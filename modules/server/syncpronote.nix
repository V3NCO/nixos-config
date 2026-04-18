{ config, pkgs, ... }:

{
  imports = [ ./syncpronote/service.nix ];

  services.syncpronote = {
    enable = true;
    secrets = /var/lib/syncpronote/secrets.json;
    classnames = /var/lib/syncpronote/utils/classnames.js;
    customHours = /var/lib/syncpronote/utils/custom-hours.js;
  };
}
