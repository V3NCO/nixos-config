{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    enablePlasmaBrowserIntegration = true;
    extensions = [
      "ddkjiahejlhfcafbddmgiahcphecmpfh"
      "nngceckbapebfimnlniiiahkandclblb"
    ];
  };
  environment.systemPackages = with pkgs; [
    chromium
    brave
    ungoogled-chromium
  ];
}
