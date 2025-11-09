{ pkgs, ... }:
{
  imports = [
    ./gnome.nix
    ./greet.nix
  ];
  environment.systemPackages = [ pkgs.kdePackages.full ];
}
