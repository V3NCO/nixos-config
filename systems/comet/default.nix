{ ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos/basic
    ../../modules/nixos/desktop
    ../../modules/nixos/printing.nix
    ../../modules/nixos/ssh.nix
    ../../modules/nixos/xserver.nix
    ../../modules/nixos/polkit.nix
    ../../modules/nixos/drawing_tablets.nix
    ../../users
  ];

  programs.nix-ld.enable = true;
  networking.hostName = "comet";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}
