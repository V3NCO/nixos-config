{ pkgs, ... }:
{
  # twin just install the OpenDeck Flatpak atp
  programs.streamdeck-ui = {
    enable = false;
    autoStart = false;
  };
}
