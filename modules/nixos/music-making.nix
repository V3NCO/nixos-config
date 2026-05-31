{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zrythm
    openutau
    distrho-ports
    zam-plugins
    lsp-plugins
    x42-plugins
    helm
    dexed
    zynaddsubfx
    geonkick
  ];
}
