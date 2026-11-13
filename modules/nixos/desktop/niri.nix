{ inputs, pkgs, unstable, ... }:
{
  nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];

  environment.systemPackages = with pkgs; [
    wl-clipboard # Clipboard support
    wlr-randr # Output management
    xwayland-satellite # X11 app support (non-native on niri)
    dragon-drop # Drag and drop support
  ];


  programs.niri = {
    enable = true;
    package = unstable.niri;
  };

  systemd.user.services.niri-flake-polkit.enable = false;
}
