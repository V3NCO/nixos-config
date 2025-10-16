{config, lib, pkgs, ...}:
{
  imports =
    [
      ./hardware-configuration.nix
      ./networking.nix
      ../../modules/nixos/basic
      ../../users/venco-server.nix
    ];

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    services.fail2ban.enable = true;
    services.openssh = {
      enable = true;
      settings = {
          PasswordAuthentication = true;
          AllowUsers = ["venco" "root"]; # Allows all users by default. Can be [ "user1" "user2" ]
          UseDns = true;
          X11Forwarding = false;
          PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
        };
    };
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "25.05";
}
