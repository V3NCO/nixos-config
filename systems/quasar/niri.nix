{ ... }:
{
  programs.niri.settings = {
    input.keyboard.numlock = true;
    outputs = {
      "HDMI-A-2" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 143.996002;
        };
        scale = 1;
        transform.rotation = 0;
        position = { x=0; y=0; };
        focus-at-startup = true;
      };
      "DP-1" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.0;
        };
        scale = 1;
        transform.rotation = 0;
        position = { x=1920; y=0; };
        focus-at-startup = false;
      };
      "DP-2" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.0;
        };
        scale = 1;
        transform.rotation = 0;
        position = { x=-1920; y=0; };
        focus-at-startup = false;
      };

      # Drawing tablet
      "HDMI-A-1" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.0;
        };
        scale = 1;
        transform.rotation = 0;
        position = { x=3840; y=0; };
        focus-at-startup = false;
      };
    };
  };
}
