{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
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
    ../../modules/nixos/music-making.nix
    ../../users
    ../../modules/nixos/flipperzero.nix
    ../../modules/nixos/cider.nix
    ../../modules/nixos/maccam.nix
    ./hyprland/monitors.nix
  ];

  environment.systemPackages = [
    pkgs.android-studio-full
    pkgs.python313
    pkgs.python313Packages.pip
  ];

  networking.firewall.allowedTCPPorts = [ 8000 ];
  networking.firewall.allowedUDPPorts = [ 8000 ];

  programs.nix-ld.enable = true;
  networking.hostName = "quasar";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;
  system.stateVersion = "25.05";
  hardware.ledger.enable = true;
}
