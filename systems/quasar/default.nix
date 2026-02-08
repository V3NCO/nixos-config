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
    ../../modules/nixos/music-making.nix
    ../../users
    ../modules/nixos/editors
    ../modules/nixos/browsers
    ../modules/nixos/steam.nix
    ../../modules/server/fail2ban.nix
    ../../modules/nixos/flipperzero.nix
    ../../modules/nixos/cider.nix
    ../../modules/nixos/maccam.nix
    ../../modules/nixos/desktop/nvidia.nix
    ./hyprland/monitors.nix
    ./keyboard.nix
  ];

  programs.gpu-screen-recorder.enable = true; # For promptless recording on both CLI and GU
  environment.systemPackages = with pkgs; [
    gpu-screen-recorder-gtk # GUI app
  ];

  systemd.tmpfiles.rules = [
    ''L+ /run/gdm/.config/monitors.xml - - - - ${./monitors.xml}''
  ] ++ builtins.attrValues (builtins.mapAttrs (n: v: "L+ /home/${n}/.config/monitors.xml - - - - ${./monitors.xml}") {venco = "venco";});

  virtualisation.docker = {
    enable = true;
  };
  services.flatpak.enable = true;
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [
        "venco"
        "root"
      ]; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = true;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

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

  networking.firewall.allowedTCPPorts = [ 8000 ];
  networking.firewall.allowedUDPPorts = [ 8000 ];

  programs.nix-ld.enable = true;
  networking.hostName = "quasar";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;
  system.stateVersion = "25.11";
  hardware.ledger.enable = true;
}
