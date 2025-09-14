{ pkgs, ... }:
{
  hardware.flipperzero.enable = true;
  environment.systemPackages = [
    pkgs.qFlipper
    pkgs.python313Packages.pyflipper
  ];
}
