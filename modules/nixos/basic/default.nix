{ ... }:
{
  imports = [
    ./generic.nix
    ./audio.nix
    ./bootloader.nix
    ./locale.nix
    ./networking.nix
    ./smartcards.nix
    ./bluetooth.nix
    ./direnv.nix
    ./terminal.nix
  ];
}
