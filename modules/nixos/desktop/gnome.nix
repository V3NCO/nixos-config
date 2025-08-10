{config, pkgs, ...}:
{
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  programs.dconf  = {
    enable = true;
    profiles = {
      user.databases = [
        {
          settings = {
            "org/gnome/desktop/interface" = {
              clock-format = "24h";
              gtk-theme = "Adwaita-dark";
              color-scheme = "prefer-dark";
              clock-show-weekday = true;
              show-battery-percentage = true;
              clock-show-seconds = true;
            };
          };
        }
      ];
    };
  };
}
