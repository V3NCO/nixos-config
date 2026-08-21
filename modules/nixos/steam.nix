{pkgs, ...}:
{
  programs.steam = {
    enable = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
    protontricks.enable = true;
    extest.enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        renice = 10;
        inhibit_screensave = 1;
      };

      cpu = {
        game_mode_performance = "performance";
        pin_cores = "no";
      };

      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        nv_powermode_level = 3;
      };
    };
  };

  users.users.venco.extraGroups = [ "gamemode" ];

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  hardware.steam-hardware.enable = true;
  hardware.graphics.enable32Bit = true;

  boot.kernelModules = [
      "uhid"             # HID over GATT via BlueZ
      "hid-sony"         # DS3/DS4 legacy path
      "hid-playstation"  # DS4/DualSense on newer kernels
    ];

  # BlueZ: enable experimental (helps with PlayStation features and DS3 pairing)
  hardware.bluetooth.settings.General.Experimental = true;
}
