{ pkgs, inputs, ... }:
{
  imports = [
    ./venco.nix
  ];

  users.defaultUserShell = pkgs.zsh;
}
