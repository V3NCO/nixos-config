{pkgs, ...}:
{
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;

    wireplumber = {
      enable = true;
      extraConfig = {
        "10-restrict-mic" = {
          "access.rules" = [
            {
              "matches" = [
                {
                  "application.process.binary" = "slack";
                }
              ];
              "actions" = {
                "update-props" = {
                  "default_permissions" = "rx";
                };
              };
            }
            {
              "matches" = [
                {
                  "application.process.binary" = "electron";
                }
              ];
              "actions" = {
                "update-props" = {
                  "default_permissions" = "rx";
                };
              };
            }
            {
              "matches" = [
                {
                  "application.process.binary" = "chromium";
                }
              ];
              "actions" = {
                "update-props" = {
                  "default_permissions" = "rx";
                };
              };
            }
          ];
        };
      };
    };
  };
  environment.systemPackages = [pkgs.pavucontrol];
}
