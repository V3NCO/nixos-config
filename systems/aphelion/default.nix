{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ../../modules/nixos/basic
    ../../modules/server/tailscale.nix
    ../../modules/server/nginx.nix
    ../../modules/server/fail2ban.nix
    ../../users/venco-server.nix
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [
        "venco"
        "root"
      ]; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}
