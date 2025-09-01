{ pkgs, ... }:
{
  imports = [
    ./venco.nix
  ];

  users.defaultUserShell = pkgs.zsh;
}
