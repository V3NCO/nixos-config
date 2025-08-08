{pkgs, config, inputs, ...}:
{    
  imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos/basic
      ../../modules/nixos/gnome.nix
      ../../modules/nixos/printing.nix
      ../../modules/nixos/ssh.nix
      ../../modules/nixos/xserver.nix
      ../../users
  ];


  networking.hostName = "quasar";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}