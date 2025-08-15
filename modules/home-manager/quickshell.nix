{ inputs, ... }:
{
  imports = [
    "${inputs.hm-unstable}/modules/programs/quickshell.nix"
  ];

  programs.quickshell = {
    enable = true;
  };
}
