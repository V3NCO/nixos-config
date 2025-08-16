{ config, ... }:
{
  home.file."${config.home.homeDirectory}/.config/quickshell".source =
  config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos-config/modules/home-manager/quickshell/qml";
}
