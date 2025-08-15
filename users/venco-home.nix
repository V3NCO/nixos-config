{ ... }:

{
  home.username = "venco";
  home.homeDirectory = "/home/venco";
  home.stateVersion = "25.05";
  # home.packages = with pkgs; [];

  imports = [
    ../modules/home-manager/quickshell.nix
    ../modules/home-manager/gpg.nix
    ../modules/home-manager/git.nix
    ../modules/home-manager/kitty.nix
    ../modules/home-manager/desktop/niri
    ../modules/home-manager/direnv.nix
  ];
}
