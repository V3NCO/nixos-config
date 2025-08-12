{ config, pkgs, inputs, ... }:

{
  home.username = "venco";
  home.homeDirectory = "/home/venco";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    # Avoid using home-manager as much as possible because it doesnt get generations like nixos apparently idk
  ];


  imports = [
    ../modules/home-manager/gpg.nix
    ../modules/home-manager/git.nix
    ../modules/home-manager/kitty.nix
    ../modules/home-manager/desktop/niri
  ];
}
