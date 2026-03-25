{pkgs, inputs, ...}:
{
  home.packages = [
    inputs.qml-niri.packages.${pkgs.stdenv.hostPlatform.system}.default
    ((inputs.quickshell-blur.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      withJemalloc = true;
      withQtSvg = true;
      withWayland = true;
      withX11 = false;
      withPipewire = true;
      withPam = true;
    }).overrideAttrs (prevAttrs: {
      buildInputs = [ pkgs.qt6.qt5compat inputs.qml-niri.packages.${pkgs.stdenv.hostPlatform.system}.qml-niri ] ++ prevAttrs.buildInputs;
    }))
  ];


  imports = [
    ./quickshell.nix
  ];
}
