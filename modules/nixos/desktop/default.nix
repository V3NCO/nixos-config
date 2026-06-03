{ pkgs, ... }:
{
  imports = [
    ./portal.nix
    ./gnome.nix
    ./greet.nix
    ./niri.nix
    ./kde.nix
  ];

  environment.systemPackages = [ pkgs.kdePackages.qtdeclarative ];
}
