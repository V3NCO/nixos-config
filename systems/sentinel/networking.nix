{ lib, ... }:
{
  networking = {
    networkmanager.enable = lib.mkForce false;

    defaultGateway = {
      address = "192.168.0.254";
      interface = "br0";
    };

    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    useNetworkd = true;
    nftables.enable = true;

    bridges.br0 = {
      interfaces = [ "enp86s0" ];
    };

    interfaces.br0.ipv4.addresses = [
        { address = "192.168.0.221"; prefixLength = 24; }
      ];

    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        53
        80
        443
      ];
      allowedUDPPorts = [
        53
      ];
    };
  };
}
