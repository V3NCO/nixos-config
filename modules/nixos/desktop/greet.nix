{ pkgs, ... }:
{
  environment.systemPackages = [];
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoNumlock = true;
    package = pkgs.kdePackages.sddm;
  };
}
