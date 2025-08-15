{pkgs, ...}:
{
  environment.systemPackages = [(
    pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font  = "Noto Sans";
      fontSize = "9";
      background = "${./wallpaper.gif}";
      loginBackground = true;
    }
  )];
  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha";
    wayland.enable = true;
    autoNumlock = true;
    package = pkgs.kdePackages.sddm;
  };
}
