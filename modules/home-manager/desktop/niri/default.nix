{
  pkgs,
  lib,
  hostname,
  ...
}:
let
  inherit (lib) attrByPath concatStringsSep;

  # Derivation that contains original + blurred/darkened version
  common = builtins.readFile ./config.kdl;
  hostsFile = {
    comet = ../../../../systems/comet/niri.kdl;
    quasar = ../../../../systems/quasar/niri.kdl;
  };

  hostFile = attrByPath [ hostname ] null hostsFile;
  hostExtra = if hostFile == null then "" else builtins.readFile hostFile;
  wallext = "jpg";

  wallpaperPkg = pkgs.stdenv.mkDerivation {
    pname = "custom-wallpaper";
    version = "1.0";
    src = ../wallpapers/wall.${wallext}; # Adjust path if you move the image
    dontUnpack = true;
    nativeBuildInputs = [ pkgs.imagemagick ];
    installPhase = ''
      mkdir -p $out
      cp $src $out/wall.${wallext}
      # Blur + darken (tweak values to taste):
      # -blur 0x18  (radius 0, sigma 18 ~ fairly strong)
      # -brightness-contrast -15x-5  (slightly darker, lower contrast)
      # For GIFs, take the first frame and convert to JPG for the blurred version
      convert "$src[0]" -blur 0x35 -brightness-contrast -20x-5 "$out/wall-blur.jpg"
    '';
  };

  HOME = "/home/venco";

in
{
  home.packages = with pkgs; [
    wallpaperPkg
    apple-cursor # (So you can manually inspect outputs if desired)
  ];

  # Install (symlink) the generated images into the user's home dir.
  home.file.".local/share/wallpapers/wall.${wallext}".source = "${wallpaperPkg}/wall.${wallext}";
  home.file.".local/share/wallpapers/wall-blur.jpg".source = "${wallpaperPkg}/wall-blur.jpg";

  # Simple startup script (no on-the-fly convert needed now).
  home.file.".local/bin/wallpaper-start" = {
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      WALL="${HOME}/.local/share/wallpapers/wall.${wallext}"
      BLUR="${HOME}/.local/share/wallpapers/wall-blur.jpg"

      # Start swww daemon if not already running (launch directly instead of 'swww init')
      if ! pgrep -x swww-daemon >/dev/null 2>&1; then
        swww-daemon >/dev/null 2>&1 &
        disown
        sleep 0.15
      fi

      swww img "$WALL" --transition-type fade --transition-duration 1 || true

      # Restart swaybg with blurred backdrop
      pkill -x swaybg 2>/dev/null || true
      (swaybg -m fill -i "$BLUR" >/dev/null 2>&1 & disown)
    '';
    executable = true;
  };

  xdg.configFile."niri/config.kdl".text = concatStringsSep "\n\n\n" [
    common
    hostExtra
  ];
}
