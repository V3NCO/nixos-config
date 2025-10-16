{ ... }:
{
  imports = [
    ./generic.nix
    ./audio.nix
    ./bootloader.nix
    ./locale.nix
    ./smartcards.nix
    ./direnv.nix
    ./terminal.nix
  ];
}
