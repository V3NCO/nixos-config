{ ... }:
{
  services.xserver.xkb = {
    layout = "fr";
    variant = "azerty";
  };

  console.keyMap = "fr";
  # programs.hyprland.settings.input.kb_layout = "fr";
  programs.dconf = {
    enable = true;
    profiles = {
      user.databases = [
        {
          settings = {
            "org/gnome/desktop/input-sources" = {
              sources = [ "('xkb', 'fr')" ];
              xkb-options = [ "terminate:ctrl_alt_bksp" ];
            };
          };
        }
      ];
    };
  };
}
