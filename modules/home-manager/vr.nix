{ config, pkgs, osConfig, ... }:
let
  wivrnRuntime = "${osConfig.services.wivrn.package}/share/openxr/1/openxr_wivrn.json";
  steamvrRuntime = "${config.xdg.dataHome}/Steam/steamapps/common/SteamVR/steamxr_linux64.json";

  wivrnVrpaths = pkgs.writeText "openvrpaths-wivrn.json" ''
    {
      "config" :
      [
        "${config.xdg.dataHome}/Steam/config"
      ],
      "external_drivers" : null,
      "jsonid" : "vrpathreg",
      "log" :
      [
        "${config.xdg.dataHome}/Steam/logs"
      ],
      "runtime" :
      [
        "${pkgs.opencomposite}/lib/opencomposite"
      ],
      "version" : 1
    }
  '';

  steamvrVrpaths = pkgs.writeText "openvrpaths-steamvr.json" ''
    {
      "config" :
      [
        "${config.xdg.dataHome}/Steam/config"
      ],
      "external_drivers" : null,
      "jsonid" : "vrpathreg",
      "log" :
      [
        "${config.xdg.dataHome}/Steam/logs"
      ],
      "runtime" :
      [
        "${config.xdg.dataHome}/Steam/steamapps/common/SteamVR"
      ],
      "version" : 1
    }
  '';

  vrSwitch = pkgs.writeShellScriptBin "vr-switch" ''
    MODE=''${1:-}
    XR_DIR="${config.xdg.configHome}/openxr/1"
    VR_DIR="${config.xdg.dataHome}/openvr"

    mkdir -p "$XR_DIR" "$VR_DIR"

    case "$MODE" in
      wivrn)
        ln -sf "${wivrnRuntime}" "$XR_DIR/active_runtime.json"
        ln -sf "${wivrnVrpaths}" "$VR_DIR/openvrpaths.vrpath"
        echo "Switched to WiVRn (OpenComposite → WiVRn)"
        ;;
      steamvr)
        ln -sf "${steamvrRuntime}" "$XR_DIR/active_runtime.json"
        ln -sf "${steamvrVrpaths}" "$VR_DIR/openvrpaths.vrpath"
        echo "Switched to SteamVR"
        ;;
      *)
        echo "Usage: vr-switch [wivrn|steamvr]"
        CURRENT=$(readlink -f "$XR_DIR/active_runtime.json" 2>/dev/null || echo "unknown")
        echo "Current OpenXR: $CURRENT"
        CURRENT_VR=$(readlink -f "$VR_DIR/openvrpaths.vrpath" 2>/dev/null || echo "unknown")
        echo "Current OpenVR: $CURRENT_VR"
        ;;
    esac
  '';
in
{
  home.packages = [ pkgs.opencomposite vrSwitch ];

  # Default: WiVRn via OpenComposite
  xdg.configFile."openxr/1/active_runtime.json".source = wivrnRuntime;

  xdg.dataFile."openvr/openvrpaths.vrpath".text = ''
    {
      "config" :
      [
        "${config.xdg.dataHome}/Steam/config"
      ],
      "external_drivers" : null,
      "jsonid" : "vrpathreg",
      "log" :
      [
        "${config.xdg.dataHome}/Steam/logs"
      ],
      "runtime" :
      [
        "${pkgs.opencomposite}/lib/opencomposite"
      ],
      "version" : 1
    }
  '';
}
