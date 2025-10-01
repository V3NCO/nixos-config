{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      cider-2 =
        (import inputs.nixpkgs-unstable {
          system = final.system;
          config.allowUnfree = true;
        }).cider-2;
    })
  ];
  environment.systemPackages = [ pkgs.cider-2 ];
}
