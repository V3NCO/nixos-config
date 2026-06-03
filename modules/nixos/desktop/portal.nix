{ pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [ "gtk" ];
      };

      GNOME = {
        default = [ "gnome" "gtk" ];
      };

      KDE = {
        default = [ "kde" "gtk" ];
      };

      plasma = {
        default = [ "kde" "gtk" ];
      };

      niri = {
        default = [ "wlr" "gtk" ];
      };
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-termfilechooser
    ];
  };
}
