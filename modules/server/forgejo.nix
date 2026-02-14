{ lib, pkgs, config, ... }:
let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
in
{
  homelab.ports = [srv.HTTP_PORT];
  services.forgejo = {
    enable = true;
    database.type = "postgres";
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "git.v3nco.dev";
        ROOT_URL = "https://${srv.DOMAIN}/";
        HTTP_PORT = 3823;
        SSH_PORT = lib.head config.services.openssh.ports;
      };
      service.DISABLE_REGISTRATION = false;
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
    };
  };

  services.gitea-actions-runner = {
    package = pkgs.forgejo-runner;
    instances.default = {
      enable = true;
      name = "monolith";
      url = "https://git.v3nco.dev";
      tokenFile = /var/lib/forgjo-runner/monolith-token;
      labels = [
        "ubuntu-latest:docker://node:16-bullseye"
        "ubuntu-22.04:docker://node:16-bullseye"
        "ubuntu-20.04:docker://node:16-bullseye"
        "ubuntu-18.04:docker://node:16-buster"
      ];
    };
    };

}
