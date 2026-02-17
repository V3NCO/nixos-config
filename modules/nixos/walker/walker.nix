{ pkgs, inputs, ... }:
{
  imports = [inputs.walker.nixosModules.default];
  environment.systemPackages = [ pkgs.rbw  pkgs.wl-clipboard pkgs.wtype ];
  programs.walker = {
    enable = true;

    config = {
      theme = "venco-walker-theme";
      # placeholders."default" = { input = "Search"; list = "Example"; };
      providers.prefixes = [
        {provider = "websearch"; prefix = "+";}
        {provider = "providerlist"; prefix = "_";}
        {provider = "bitwarden"; prefix = "\\";}
      ];
      keybinds.quick_activate = ["F1" "F2" "F3"];
    };

    elephant = {
      providers = [
        "bluetooth"
        "bookmarks"
        "calc"
        "clipboard"
        "desktopapplications"
        "files"
        "menus"
        "providerlist"
        "runner"
        "snippets"
        "symbols"
        "unicode"
        "websearch"
        "bitwarden"
        "nirisessions"
        "niriactions"
      ];
    };

    themes = {
      "venco-walker-theme" = {
        # Check out the default css theme as an example https://github.com/abenz1267/walker/blob/master/resources/themes/default/style.css
        style = builtins.readFile ./themes/venco-walker-theme/theme.css;

        layouts = {
          "layout" = builtins.readFile ./themes/venco-walker-theme/layout.xml;
        };
      };
    };
  };
}
