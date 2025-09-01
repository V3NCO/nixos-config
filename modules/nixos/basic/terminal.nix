{ ... }:
{
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
    };
    autosuggestions = {
      enable = true;
      async = true;
      highlightStyle = "fg=7";
    };
    shellAliases = {
      "nixconf" = "sudo nixos-rebuild switch --flake ~/nixos-config";
    };
    syntaxHighlighting.enable = true;
    histSize = 10000;
    vteIntegration = true;
    enableLsColors = true;
    enableBashCompletion = true;
  };
}
