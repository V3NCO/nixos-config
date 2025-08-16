{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    vscode-fhs
    zed-editor-fhs
  ];
}
