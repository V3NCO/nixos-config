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
    ../../modules/server/fail2ban.nix
    ../../modules/nixos/flipperzero.nix
    ../../modules/nixos/cider.nix
    ../../modules/nixos/maccam.nix
    ../../modules/nixos/desktop/nvidia.nix
    ./hyprland/monitors.nix
    ./keyboard.nix
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
  system.stateVersion = "25.11";
  hardware.ledger.enable = true;
}
