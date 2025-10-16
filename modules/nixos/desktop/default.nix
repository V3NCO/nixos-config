{...}:
{
  imports = [
    ./gnome.nix
    ./niri.nix
    ./greet.nix
  ];
  environment.systemPackages = [ pkgs.kdePackages.full ];
}
