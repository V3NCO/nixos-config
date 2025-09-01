{ pkgs, inputs, ... }:
{
  imports = [
    ./venco.nix
  ];

  users.defaultUserShell = pkgs.zsh;
  fonts.packages = [
    inputs.apple-fonts.packages.${pkgs.system}.sf-pro
    inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd
    inputs.apple-fonts.packages.${pkgs.system}.sf-compact
    inputs.apple-fonts.packages.${pkgs.system}.sf-compact-nerd
    inputs.apple-fonts.packages.${pkgs.system}.sf-mono
    inputs.apple-fonts.packages.${pkgs.system}.sf-mono-nerd
    inputs.apple-fonts.packages.${pkgs.system}.sf-arabic
    inputs.apple-fonts.packages.${pkgs.system}.sf-arabic-nerd
    inputs.apple-fonts.packages.${pkgs.system}.sf-armenian
    inputs.apple-fonts.packages.${pkgs.system}.sf-armenian-nerd
    inputs.apple-fonts.packages.${pkgs.system}.sf-georgian
    inputs.apple-fonts.packages.${pkgs.system}.sf-georgian-nerd
    inputs.apple-fonts.packages.${pkgs.system}.sf-hebrew
    inputs.apple-fonts.packages.${pkgs.system}.sf-hebrew-nerd
    inputs.apple-fonts.packages.${pkgs.system}.ny
    inputs.apple-fonts.packages.${pkgs.system}.ny-nerd
    pkgs.nerd-fonts.lilex
  ];
}
