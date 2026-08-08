{ ... }:
{
  programs.niri.settings = {
    input.keyboard.numlock = true;
    binds = {
      "Mod+Shift+S".action.screenshot = [];
      "Mod+Shift+Ctrl+S".action.screenshot-screen = [];
      "Mod+Shift+Alt+S".action.screenshot-window = [];
    };
  };
}
