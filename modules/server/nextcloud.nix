{ config, pkgs, ... }:
{
  homelab.services.nextcloud = {
    subdomain = "nextcloud";
    zone = "v3nco";
    upstream = {
      scheme = "http";
      host = "127.0.0.1";
      port = 8934;
    };
    middlewares = [ "security-headers" ];
  };

  homelab.ports = [ 8934 ];

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud33;
    extraAppsEnable = true;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
    };
    hostName = "https://nextcloud.v3nco.dev";
    config.dbtype = "sqlite";
    maxUploadSize = "10G";
  };

  services.nginx.virtualHosts."${config.services.nextcloud.hostName}".listen = [ { addr = "127.0.0.1"; port = 8934; } ];
}
