{ pkgs, ... }:
{
  imports = [
    ./gnome.nix
    ./greet.nix
    ./niri.nix
  ];

  environment.systemPackages = [ pkgs.kdePackages.qtdeclarative ];
}
