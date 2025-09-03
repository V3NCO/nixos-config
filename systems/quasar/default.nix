{ pkgs, ... }:
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
    ../../modules/nixos/theming/catppuccin.nix
    ../../users
  ];

  environment.systemPackages = with pkgs; [
    android-studio-full
  ];

  programs.nix-ld.enable = true;
  networking.hostName = "quasar";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;
  system.stateVersion = "25.05";
  hardware.ledger.enable = true;
}
