{ config, pkgs, lib, ... }:

let
  cfg = config.services.syncpronote;
  syncpronote-pkg = config.services.syncpronote.package;

  # Create a separate shell script for the pre-start logic.
  # This avoids the purity error by isolating the use of the absolute path string.
  preStartScript = pkgs.writeShellScript "syncpronote-pre-start" ''
    #!${pkgs.runtimeShell}
    set -e
    mkdir -p "${cfg.dataDir}/.config"
    mkdir -p "${cfg.dataDir}/utils"
    cp "${cfg.secrets}" "${cfg.dataDir}/.config/secrets.json"

    if [ -n "${cfg.classnames}" ]; then
      cp "${cfg.classnames}" "${cfg.dataDir}/utils/classnames.js"
    fi

    if [ -n "${cfg.customHours}" ]; then
      cp "${cfg.customHours}" "${cfg.dataDir}/utils/custom-hours.js"
    fi

    chown -R "${cfg.user}:${cfg.group}" "${cfg.dataDir}"
  '';

in
{
  options.services.syncpronote = {
    enable = lib.mkEnableOption "Enable the syncpronote service";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.callPackage ./flake.nix { };
      defaultText = "pkgs.callPackage ./flake.nix { }";
      description = "The syncpronote package to use.";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "syncpronote";
      description = "User to run syncpronote as.";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "syncpronote";
      description = "Group to run syncpronote as.";
    };

    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/syncpronote";
      description = "The directory to store syncpronote data and configuration.";
    };

    secrets = lib.mkOption {
      type = lib.types.path;
      description = "Path to secrets.json";
    };

    classnames = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to a custom classnames.js file.";
    };

    customHours = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to a custom custom-hours.js file.";
    };
  };

  config = lib.mkIf cfg.enable {
    # This is the correct way to define the system user.
    # Do not set `home` to an absolute path here.
    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
      createHome = true;
    };

    users.groups.${cfg.group} = {};

    systemd.services.syncpronote = {
      description = "SyncPronote Service";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      # Use the script created above for the preStart command.
      script = ''
        exec ${syncpronote-pkg}/bin/syncpronote
      '';

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        WorkingDirectory = cfg.dataDir;
        ExecStartPre = "${preStartScript}";
        Restart = "on-failure";
      };
    };
  };
}
