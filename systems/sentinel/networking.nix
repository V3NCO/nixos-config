{ lib, ... }:
{
  networking = {
    networkmanager.enable = lib.mkForce false;

    networking.defaultGateway = "10.0.0.1";
    useNetworkd = true;
    nftables.enable = true;

    bridges.br0 = {
      interfaces = [ "enp86s0" ];
    };

    networking.interfaces.br0.ipv4.addresses = [
        { address = "192.168.0.221"; prefixLength = 24; }
      ];

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
