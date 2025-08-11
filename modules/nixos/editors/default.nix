{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    vscode
    zed-editor
  ];
}