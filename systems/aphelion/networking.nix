{config, lib, pkgs, ...}:
{
  networking = {
    defaultGateway = "45.8.201.1";
    hostName = "aphelion";
    nameservers = ["8.8.8.8" "1.1.1.1"];
    interfaces.enp3s0.ipv4.addresses = [
      {address = "45.8.201.68"; prefixLength = 24;}
    ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 ];
      allowedUDPPortRanges = [
        { from = 4000; to = 4007; }
        { from = 8000; to = 8010; }
      ];
    };
  };
}
