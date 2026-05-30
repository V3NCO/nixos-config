{ config, ... }:
{
  programs.streamcontroller = {
    enable = true;

    defaultPages."AL22K2C74512" = "Default";

    pages = {
      Default = {
        brightness.value = 100;

        keys = {
          # Battery status (mouse)
          "0x0".states."0".actions = [{
            id = "com_core447_Battery::BatteryPercentage";
            settings.device = "G502 LIGHTSPEED Wireless Gaming Mouse";
          }];

          # Run a shell command with custom icon
          "1x1".states."0" = {
            actions = [{
              id = "com_core447_OSPlugin::RunCommand";
              settings.command = "goxlr-toggle";
            }];
          };

          # Media controls
          "0x2".states."0".actions = [{
            id = "com_core447_MediaPlugin::Previous";
            settings = { show_label = true; show_thumbnail = true; };
          }];
          "1x2".states."0".actions = [{
            id = "com_core447_MediaPlugin::PlayPause";
            settings = { show_label = true; show_thumbnail = true; };
          }];
          "2x2".states."0".actions = [{
            id = "com_core447_MediaPlugin::Next";
            settings = { show_label = true; show_thumbnail = true; };
          }];
        };
      };

      # Second page with auto-change (activates when a window matches)
      controls = {
        brightness.value = 75;
        extraConfig.auto-change = {
          enable = true;
          wm_class = "";
          title = "";
          stay_on_page = true;
          decks = [ "AL22K2C74512" ];
        };

        keys = {
          # Labeled button with keyboard shortcut
          "0x0".states."0" = {
            label.center.text = "Toggle";
            actions = [{
              id = "com_core447_OSPlugin::Hotkey";
              settings.keys = [ [ 119 1 ] [ 119 0 ] ];  # F8 press/release
            }];
          };

          # Labeled button pair (increment/decrement)
          "0x1".states."0" = {
            label = { top.text = "Volume"; center.text = "+"; };
            actions = [{
              id = "com_core447_OSPlugin::RunCommand";
              settings.command = "volume-up";
            }];
          };
          "1x1".states."0" = {
            label = { top.text = "Volume"; center.text = "-"; };
            actions = [{
              id = "com_core447_OSPlugin::RunCommand";
              settings.command = "volume-down";
            }];
          };

          # Navigate back to Default page
          "4x0".states."0".actions = [{
            id = "com_core447_DeckPlugin::ChangePage";
            settings = {
              selected_page = "${config.programs.streamcontroller.dataPath}/pages/Default.json";
              deck_number = "AL22K2C74512";
            };
          }];
        };
      };
    };
  };
}
