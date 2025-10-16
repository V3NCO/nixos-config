{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.spaceship-prompt pkgs.alacritty ];
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "spaceship";
      custom = "${pkgs.spaceship-prompt}/share/zsh/themes";
    };
    autosuggestions = {
      enable = true;
      async = true;
      highlightStyle = "fg=7";
    };
    shellAliases = {
      "nixconf" = "sudo nixos-rebuild switch --flake ~/nixos-config";
    };
    shellInit = ''
      SPACESHIP_TIME_SHOW=true
      SPACESHIP_USER_SHOW=always
    '';
    syntaxHighlighting.enable = true;
    histSize = mkDefault 10000;
    vteIntegration = true;
    enableLsColors = true;
    enableBashCompletion = true;
  };
}
