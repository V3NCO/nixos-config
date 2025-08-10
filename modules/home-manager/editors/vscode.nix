{ config, pkgs, ...  }:
{
  programs.vscode = {
    enable = true;
    profile.default = {
      extensions = [
        pkgs.vscode-extensions.bbenoist.nix
        pkgs.vscode-extensions.wakatime.vscode-wakatime
      ];
    };
  };
}
