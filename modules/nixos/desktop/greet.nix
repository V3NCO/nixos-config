{ pkgs, ... }:
{
  environment.systemPackages = [];
  services.displayManager.sddm = {
    enable = true;
    #theme = "catppuccin-mocha";
    wayland.enable = true;
    autoNumlock = true;
    package = pkgs.kdePackages.sddm;
  };
}
