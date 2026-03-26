{ pkgs, ... }:
{
  imports = [ ./hass.nix ];

  environment.systemPackages = with pkgs; [
    qemu_kvm
    virt-manager
    libvirt
    bridge-utils
  ];

  homelab.ports = [ 8443 ];
  homelab.services.incus = {
    subdomain = "incus";
    zone = "v3nco";
    upstream = {
      scheme = "https";
      host = "127.0.0.1";
      port = 8443;
    };
    middlewares = [ "security-headers" ];
  };

  virtualisation = {
    incus = {
      enable = true;
      ui.enable = true;
      preseed = {
        config = {
          "core.https_address" = "127.0.0.1:8443";
          "oidc.client.id" = "2c0df8c4-e6c2-43cc-a2dd-70a545838ae1"; #find a way to change this someday, i dont like hardcoding the client id that isnt declarative
          "oidc.issuer" = "https://pid.v3nco.dev";
          "oidc.scopes" = "openid,email,profile";
        };

        storage_pools = [
          {
            config = {
              source = "/var/lib/incus/storage-pools/default";
            };
            driver = "dir";
            name = "default";
          }
        ];
        profiles = [
          {
            name = "default";
            devices = {
              eth0 = {
                name = "eth0";
                nictype = "bridged";
                parent = "br0";
                type = "nic";
              };
              root = {
                path = "/";
                pool = "default";
                type = "disk";
              };
            };
          }
        ];
      };
    };

    libvirtd.enable = true;
  };
  systemd.services."incus-preseed".after = [ "network-online.target" ];
  systemd.services."incus-preseed".wants = [ "network-online.target" ];
}
