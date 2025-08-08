{ config, pkgs, zen-browser, inputs, ... }:

{
  home.username = "venco";
  home.homeDirectory = "/home/venco";

  home.packages = with pkgs; [
    # Avoid using home-manager as much as possible because it doesnt get generations like nixos apparently idk   
  ];

  
  imports = [
    ../modules/home-manager/gpg.nix
  ];
}