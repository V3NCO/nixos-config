{ pkgs, ... }:
{
  programs.kdeconnect.enable = true;
  environment.systemPackages = [ pkgs.kdePackages.qttools ];
}
