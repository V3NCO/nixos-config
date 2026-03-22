{ pkgs, ... }:
{
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
      scheme = "http";
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
        networks = [
          {
            name = "incusbr0";
            type = "bridge";
            config = {
              "ipv4.address" = "10.0.100.1/24";
              "ipv4.nat" = "true";
            };
          }
        ];
        storage_pools = [
          {
            name = "zfs-incus";
            driver = "zfs";
            config = {
              source = "rpool/incus";
            };
          }
        ];
        profiles = [
          {
            name = "default";
            devices = {
              eth0 = {
                name = "eth0";
                network = "incusbr0";
                type = "nic";
              };
              root = {
                path = "/";
                pool = "zfs-incus";
                type = "disk";
              };
            };
          }
        ];
      };
    };

    libvirtd.enable = true;
  };
}
