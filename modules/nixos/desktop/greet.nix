{ inputs, pkgs, ... }:
{
  imports = [inputs.silentSDDM.nixosModules.default];
  environment.systemPackages = [];
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoNumlock = true;
    package = pkgs.kdePackages.sddm;
  };

  programs.silentSDDM = {
    enable = true;
    theme = "rei";
  };
}
