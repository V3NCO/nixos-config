{pkgs, config, ...}:
{
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs [
      proton-ge-bin
    ];
    protontricks.enable = true;
    extest.enable = true;
    remotePlay.openFirewall = true;
  };
  hardware.steam-hardware.enable = true;
}
