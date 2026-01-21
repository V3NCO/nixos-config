{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./apple-silicon-support
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
    ../../modules/nixos/flipperzero.nix
    ../../users
    ./keyboard.nix
  ];

  virtualisation.docker = {
    enable = true;
  };
  services.flatpak.enable = true;

  networking.firewall.allowedTCPPorts = [ 8000 ];
  networking.firewall.allowedUDPPorts = [ 8000 ];
  networking.nameservers = ["1.1.1.1" "9.9.9.9"];
  time.timeZone = "Europe/Paris";
  networking.networkmanager.enable = true;
  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  programs.gpu-screen-recorder.enable = false;
  programs.nix-ld.enable = true;
  networking.hostName = "stardust";
  system.stateVersion = "25.11";
  hardware.ledger.enable = true;

  # avoid Asahi firmware extraction when firmware not provided
  hardware.asahi.extractPeripheralFirmware = false;
}
