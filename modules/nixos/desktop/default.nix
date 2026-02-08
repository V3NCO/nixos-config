{ pkgs, ... }:
{
  imports = [
    ./gnome.nix
    ./greet.nix
    ./hyprland.nix
  ];

  environment.systemPackages = [ pkgs.kdePackages.qtdeclarative ];
}
