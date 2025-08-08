{ pkgs, ...  }:
{
  home.packages = with pkgs; [
    wl-mirror # Mirror client for wayland (Niri does not support mirroring)
    swaybg
  ];

  xdg.configFile."niri/config.kdl" = {
    source = ./config.kdl;
    force = true;
  };
}
