{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nvim
    ../../modules/nixos/basic
    ../../modules/nixos/basic/networking.nix
    ../../modules/nixos/basic/bluetooth.nix
    ../../modules/nixos/desktop
    ../../modules/nixos/printing.nix
    ../../modules/nixos/ssh.nix
    ../../modules/nixos/xserver.nix
    ../../modules/nixos/polkit.nix
    ../../modules/nixos/drawing_tablets.nix
    ../../modules/nixos/theming/catppuccin.nix
    ../../modules/nixos/desktop/nvidia.nix
    ../modules/nixos/steam.nix
    ../../users
    ./keyboard.nix
    ./hyprland
  ];

  # programs.gpu-screen-recorder.enable = true; # For promptless recording on both CLI and GUI

  # environment.systemPackages = with pkgs; [
  #  gpu-screen-recorder-gtk # GUI app
  # ];

  services.flatpak.enable = true;
  environment.systemPackages = [
    pkgs.libinput
    pkgs.libinput-gestures # Add this for libinput command-line tools
  ];

  programs.light.enable = true;
  programs.nix-ld.enable = true;
  networking.hostName = "comet";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;
  system.stateVersion = "25.11";
  hardware.ledger.enable = true;
}
