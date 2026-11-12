{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zed-editor-fhs
  ];
  imports = [
    ./beekeeper.nix
    ./jetbrains.nix
  ];
}
