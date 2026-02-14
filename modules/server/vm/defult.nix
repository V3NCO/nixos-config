{ pkgs, ... }:
{
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
  
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMF ];
      };
    };
  };
}