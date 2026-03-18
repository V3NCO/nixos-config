{ config, ... }:

{
  home.username = "venco";
  home.homeDirectory = "/home/venco";
  home.stateVersion = "25.11";
  # home.packages = with pkgs; [];

  home.file."${config.xdg.configHome}/nixosassets/pfp" = {
    source = ./pfp;
    recursive = true;
  };

  home.file."Pictures/Wallpapers" = {
    source = ../wallpapers;
    recursive = true;
  };

  imports = [
    ../modules/home-manager/gpg.nix
    ../modules/home-manager/git.nix
    ../modules/home-manager/term.nix
    ../modules/home-manager/fetch.nix
    ../modules/home-manager/desktop/niri.nix
    # ../modules/home-manager/direnv.nix
    # ../modules/home-manager/quickshell
    # ../modules/home-manager/vicinae.nix
    ../modules/home-manager/desktop/gnome.nix
  ];
}
