{ config, pkgs, ... }:
{
  homelab = {
    ports = [ config.services.beszel.hub.port ];
    services.beszel = {
      subdomain = "beszel";
      zone = "v3nco";
      upstream = {
        scheme = "http";
        host = "127.0.0.1";
        port = config.services.beszel.hub.port;
      };
      middlewares = [
        "security-headers"
      ];
    };
  };

  services.beszel = {
    hub = {
      enable = true;
      port = 8329;
      dataDir = "/var/lib/beszel-hub";
      host = "127.0.0.1";
      environment = {};
      environmentFile = null;
    };

    agent = {
      enable = true;
      extraPath = [];
      environment = {};
      environmentFile = null;
      smartmon = {
        enable = true;
        package = pkgs.smartmontools;
        deviceAllow = [];
      };
      openFirewall = false;
    };
  };
}
