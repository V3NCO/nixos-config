{ pkgs, unstable, ... }:
let
  customBitwigJar = pkgs.requireFile {
    name = "bitwig.jar";
    sha256 = "sha256-D38TcFXGtTz3RSG0gQCc1H1S0NOhdI2dwrD4aIfdkfY=";
    message = "Please add bitwig.jar to your local Nix store using: nix-store --add-fixed sha256 /path/to/bitwig.jar";
  };

  customBitwig = unstable.bitwig-studio.overrideAttrs (oldAttrs: {
    src = pkgs.fetchurl {
      name = "bitwig-studio-6.1.deb";
      url = "https://www.bitwig.com/dl/Bitwig%20Studio/6.1/installer_linux";
      hash = "sha256-dJbwn8JNHuSZ/lKQV4zoSbbthDdHl4J7hhmOZ5AdA2M=";
    };
    postInstall = (oldAttrs.postInstall or "") + ''
      JAR_PATH=$(find $out -name "bitwig.jar")
      if [ -n "$JAR_PATH" ]; then
        cp -f "${customBitwigJar}" "$JAR_PATH"
      else
        echo "Could not find original bitwig.jar to replace"
        exit 1
      fi
    '';
  });
in
{
  environment.systemPackages = with pkgs; [
    zrythm
    openutau
    distrho-ports
    zam-plugins
    lsp-plugins
    x42-plugins
    helm
    dexed
    zynaddsubfx
    geonkick

    yabridge
    yabridgectl
    customBitwig
  ];
}
