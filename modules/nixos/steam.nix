{pkgs, ...}:
{
  programs.steam = {
    enable = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
    protontricks.enable = true;
    extest.enable = true;
    remotePlay.openFirewall = true;
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
