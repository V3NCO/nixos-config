{inputs, pkgs, ...}:
{
  nixpkgs.overlays = [ inputs.hamr.overlays.default ];
  environment.systemPackages = [ pkgs.hamr ];
}
