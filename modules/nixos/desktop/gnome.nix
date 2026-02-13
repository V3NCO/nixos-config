{ pkgs, ... }:
{
  # services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs; [
    fractal
  ];

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = "gnome";
        "org.freedesktop.impl.portal.ScreenCast" = "gnome";
        "org.freedesktop.impl.portal.Screenshot" = "gnome";
        "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
      };
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-termfilechooser
    ];
  };

  programs.dconf = {
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
