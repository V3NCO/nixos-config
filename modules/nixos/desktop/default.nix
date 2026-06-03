{ pkgs, ... }:
{
  imports = [
    ./portal.nix
    ./gnome.nix
    ./greet.nix
    ./niri.nix
  ];

  environment.systemPackages = [ pkgs.kdePackages.qtdeclarative ];
}
