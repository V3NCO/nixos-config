{pkgs, inputs, ...}:
{
  home.packages = [
    inputs.qml-niri.packages.${pkgs.system}.default
    ((inputs.quickshell-blur.packages.${pkgs.system}.default.override {
      withJemalloc = true;
      withQtSvg = true;
      withWayland = true;
      withX11 = false;
      withPipewire = true;
      withPam = true;
    }).overrideAttrs (prevAttrs: {
      buildInputs = [ pkgs.qt6.qt5compat inputs.qml-niri.packages.${pkgs.system}.qml-niri ] ++ prevAttrs.buildInputs;
    }))
  ];


  imports = [
    ./quickshell.nix
  ];
}
