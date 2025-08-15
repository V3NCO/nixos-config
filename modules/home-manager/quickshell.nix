{ inputs, ... }:
{
  imports = [
    inputs.hm-unstable.homeManagerModules.quickshell
  ];

  programs.quickshell = {
    enable = true;

  };
}
