{config, lib, pkgs, ...}:
{
  imports =
    [
      ./hardware-configuration.nix
      ./networking.nix
      ../../modules/nixos/basic
    ];

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    services.fail2ban.enable = true;
    services.openssh.enable = true;
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "25.05";
}
