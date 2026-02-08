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
    ../modules/nixos/browsers
    ../modules/nixos/editors
    ../modules/nixos/steam.nix
    ../../users
    ./keyboard.nix
    ./hyprland
  ];

  programs.gpu-screen-recorder.enable = true; # For promptless recording on both CLI and GU
  environment.systemPackages = with pkgs; [
   gpu-screen-recorder-gtk # GUI app
  ];

  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
    android-studio-full
    python313
    python313Packages.pip
    tor-browser
    yubikey-personalization
    yubikey-manager
    yubikey-touch-detector
    yubioath-flutter
    thunderbird
    vesktop
    slack
    zoom-us
    signal-desktop-bin
    mattermost-desktop
    spotify
    neofetch
    nnn # terminal file manager
    nodejs_24
    nix-output-monitor
    glow # markdown previewer in terminal
    godot
    godot-mono
    aseprite # I bought it on steam anyways its just convinient to have as a package
    bitwarden-cli
    blender
    virt-manager
    krita
    heroic-unwrapped
    itch
    itch-dl
    affine-bin
    anytype
    ledger-live-desktop
    osu-lazer-bin
    prismlauncher
    remmina
    owmods-cli
    owmods-gui
    ryubing
    r2modman
    libreoffice-qt-fresh
    via
  ];

  programs.light.enable = true;
  programs.nix-ld.enable = true;
  networking.hostName = "comet";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;
  system.stateVersion = "25.11";
  hardware.ledger.enable = true;
}
