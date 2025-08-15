{ inputs, pkgs, ... }:
let
  qsPkgs = inputs.quickshell.packages.${pkgs.system};
  qsPkg = (qsPkgs.quickshell or qsPkgs.default);
in
{
  imports = [
    "${inputs.hm-unstable}/modules/programs/quickshell.nix"
  ];

  programs.quickshell = {
    enable = true;
    package = qsPkg;
  };
}
