{ pkgs, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.3.4"
  ];
  environment.systemPackages = [ pkgs.beekeeper-studio ];
}