{ inputs, pkgs, ... }:
{
  imports = [inputs.silentSDDM.nixosModules.default];
  environment.systemPackages = [];
  services.displayManager.defaultSession = "niri";
  services.xserver.displayManager.setupCommands = "";
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositor = "kwin";
    };
    autoNumlock = true;
    package = pkgs.kdePackages.sddm;
  };

  programs.silentSDDM = {
    enable = true;
    theme = "default";
    profileIcons = {
      venco = ../../../users/pfp/venco.png;
    };

    backgrounds = {
      sakura = ../../home-manager/desktop/wallpapers/flowers-20.jpg;
    };

    settings = {
      "LockScreen" = {
        background = "flowers-20.jpg";
      };
      "LoginScreen" = {
        background = "flowers-20.jpg";
      };
    };
  };
}
