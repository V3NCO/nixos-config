{config, pkgs, ...}:
{
  imports = [
    ./generic.nix
    ./audio.nix
    ./bootloader.nix
    ./locale.nix
    ./networking.nix
  ]
}