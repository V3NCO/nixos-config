{ config, pkgs, ... }:
{
  home.file."${config.home.homeDirectory}/.config/quickshell".source =
    if pkgs.system == "aarch64-darwin" then config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/modules/home-manager/quickshell/mac-config"
    else config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/modules/home-manager/quickshell/pc-config";

  home.packages = [
    pkgs.cava
    pkgs.material-symbols
  ];
}
