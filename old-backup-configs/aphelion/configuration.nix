# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "aphelion"; # Define your hostname.
  networking = {
    defaultGateway = "45.8.201.1";
    nameservers = ["8.8.8.8" "1.1.1.1"];
    interfaces.enp3s0.ipv4.addresses = [
      {address = "45.8.201.68"; prefixLength = 24;}
    ];
  };
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;




  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.venco = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    openssh.authorizedKeys.keys = [
      # Stardust SSH Key
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBONQ8znwJEINzYqw077cPeQGdxuNojS1q8v2PXFbv3hFPCWEgv+Z8J+xOQHJXDaM+48Bd8g67QkKADxQtFkJHak= v3nco@v3nco.dev"
      # Sentinel SSH
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHFDwAnZIKGTxA8g0o0sQ54WP9ZCLeACy8OHrLG8OADNAAAABHNzaDo="
      # Guardian GPG
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3PiNEseKdDtTl84l6I5j7Mp5zrbRAOvJtIOHfQ1eBXQ+UP4+JD9BkxedRoAO4MFt9aHGUcy1zGEf6mouStjTcMLstpIFGG6pnMMJsFqXg+2tMBePNVGloefVkPjcCekVauTZV51Rr/rQhMLaQZzjf+CicT+/P2xPbE+6RLKwmgFxc0ChAJF4giRiDkF87zGxmuQE219IbCfBTO2dl94RvMXKGUufAJWKu+vi63fXxCVje3WBj/KtntL91aZqE4pgyuis4l9kLzL5hyKeDcM4EvEyimkX4MHDO7YwJlchCRcs1wo18i6/waC3QKYKL7Kgt+BY9Th81qJ5iAwuappotp4ssEo0N8+GxebbMYP6qi7CcsleFcGQSlzmVw2q5K64uCJ+hvI1EE0jPBXCQlJAc5NQtvsR6+FYBWZ/F87i+7y8nn3dWw1KOwXKlKiPlNI5Fn6a5NtQ20tSgyiMQFRQ30ZOwsUFvgoMKTjtsQMEaqljqo0b7L0AOsTyfAXPtY2UQtTxQYzZ7G5wxJIu6eIe8Slisa1T4XHoQGaoF9MWK/v97kYnud9Cp+jhdmlckV7fwyTb2JLF8W4IDsRA7qEgb1p/ERuRarhIkXtjb1FiXF6I+tOKhEPdzy3X9zoiP+SXuE9NzchWHZ59Mr08ZRXaV0s9XkKFRU8y7VwaOc+RSSQ== openpgp:0x148001EA"
    ];
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    nano # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services.fail2ban.enable = true;
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
