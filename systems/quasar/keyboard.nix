{ ... }:
{
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  console.keyMap = "us";
  # programs.hyprland.settings.input.kb_layout = "us";
  programs.dconf = {
    enable = true;
    profiles = {
      user.databases = [
        {
          settings = {
            "org/gnome/desktop/input-sources" = {
              sources = [ "('xkb', 'us')" ];
              xkb-options = [ "terminate:ctrl_alt_bksp" ];
            };
          };
        }
      ];
    };
  };
}
