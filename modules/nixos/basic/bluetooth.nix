{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    blueman # GUI bluetooth manager
    bluez # Official linux protocol bluetooth stack
    bluez-tools # Set of tools to manage bluetooth devices for linux
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez;
  };
  hardware.xone.enable = true;
  services = {
    blueman.enable = true;
  };
}
