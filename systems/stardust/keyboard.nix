{
  services.xserver.xkb = {
    layout = "fr";
    variant = "mac";
  };

  console.keyMap = "mac-fr";

  # programs.hyprland.settings.input.kb_layout = "fr";

  programs.dconf = {
    enable = true;
    profiles = {
      user.databases = [
        {
          settings = {
            "org/gnome/desktop/input-sources" = {
              sources = [ "('xkb', 'fr+mac')" ];
              xkb-options = [ "terminate:ctrl_alt_bksp" ];
            };
          };
        }
      ];
    };
  };
}
