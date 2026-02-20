{pkgs, inputs, ...}:
{
  home.packages = [
    inputs.qml-niri.packages.${pkgs.system}.default
    ((inputs.qml-niri.packages.${pkgs.system}.quickshell.override {
      withJemalloc = true;
      withQtSvg = true;
      withWayland = true;
      withX11 = false;
      withPipewire = true;
      withPam = true;
    }).overrideAttrs (prevAttrs: {
      buildInputs = [ pkgs.qt6.qt5compat ] ++ prevAttrs.buildInputs;
    }))
  ];


  imports = [
    ./quickshell.nix
  ];
}
