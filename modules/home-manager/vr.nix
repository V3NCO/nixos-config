{ config, osConfig, pkgs, ... }:
{
  xdg.configFile."openxr/1/active_runtime.json".source =
    "${osConfig.services.wivrn.package}/share/openxr/1/openxr_wivrn.json";
}
