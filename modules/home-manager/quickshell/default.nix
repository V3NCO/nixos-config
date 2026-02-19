{pkgs, quickshell, ...}:
{
  home.packages = [
    (quickshell.packages.${pkgs.system}.default.override {
      withJemalloc = true;
      withQtSvg = true;
      withWayland = true;
      withX11 = false;
      withPipewire = true;
      withPam = true;
      withHyprland = false;
      withI3 = false;
    })
  ];


  imports = [
    ./quickshell.nix
  ];
}
