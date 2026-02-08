{ pkgs, lib, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    inputs.apple-silicon.nixosModules.default

    ../../modules/nvim
    ../../modules/nixos/basic
    ../../modules/nixos/basic/networking.nix
    ../../modules/nixos/basic/bluetooth.nix
    ../../modules/nixos/desktop
    ../../modules/nixos/printing.nix
    ../../modules/nixos/ssh.nix
    ../../modules/nixos/xserver.nix
    ../../modules/nixos/polkit.nix
    # ../../modules/nixos/drawing_tablets.nix
    # ../../modules/nixos/theming/catppuccin.nix
    # ../../modules/nixos/flipperzero.nix
    ../../users
    ./keyboard.nix
  ];

  virtualisation.docker = {
    enable = true;
  };
  # services.flatpak.enable = true;

  networking.firewall.allowedTCPPorts = [ 8000 ];
  networking.firewall.allowedUDPPorts = [ 8000 ];
  networking.nameservers = ["1.1.1.1" "9.9.9.9"];
  time.timeZone = "Europe/Paris";
  networking.networkmanager.enable = true;
  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };
 
  nix.settings.auto-optimise-store = true;
  programs.gpu-screen-recorder.enable = false;
  programs.nix-ld.enable = true;
  networking.hostName = "stardust";
  system.stateVersion = "25.11";
  hardware.ledger.enable = true;
  services.libinput.enable = true;

  nix.settings = {
    extra-substituters = [
      "https://nixos-apple-silicon.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
    ];
  };

  # avoid Asahi firmware extraction when firmware not provided
  hardware.asahi.extractPeripheralFirmware = false;
}
