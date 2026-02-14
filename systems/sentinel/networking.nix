{ lib, ... }:
{
  networking = {
    networkmanager.enable = lib.mkForce false;

    useNetworkd = true;
    nftables.enable = true;

    bridges.br0 = {
      interfaces = [ "enp86s0" ];
    };

    interfaces.br0 = {
      useDHCP = true;
    };
    
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
      ];
      allowedUDPPortRanges = [ ];
    };
  };
}
