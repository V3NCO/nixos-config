{ pkgs, inputs, ... }:
let
  googleSansFlex = pkgs.stdenvNoCC.mkDerivation {
    pname = "google-sans-flex";
    version = "local";

    src = ./Google_Sans_Flex;

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/fonts/truetype
      cp -v *.ttf *.otf $out/share/fonts/truetype/ 2>/dev/null || true
      runHook postInstall
    '';
  };
in {
  fonts.packages = [
    pkgs.corefonts
    pkgs.vista-fonts
    inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro
    #  inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro-nerd
    inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-compact
    #  inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-compact-nerd
    inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-mono
    #  inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-mono-nerd
    #   inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-arabic
    #   inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-arabic-nerd
    #   inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-armenian
    #   inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-armenian-nerd
    #   inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-georgian
    #   inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-georgian-nerd
    #   inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-hebrew
    #   inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-hebrew-nerd
    inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.ny
    #  inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.ny-nerd
    pkgs.nerd-fonts.lilex
    pkgs.roboto-flex
    pkgs.roboto-mono
    pkgs.roboto-slab
    pkgs.roboto-serif
    googleSansFlex
  ];
}
