{ self, config, pkgs, lib, ... }: # Note: 'self' is added here

let
  cfg = config.services.syncpronote;
  # The package is now referenced directly from the flake's outputs.
  syncpronote-pkg = cfg.package;

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
      # The default now correctly points to the package from the flake.
      default = self.packages.${pkgs.system}.default;
      defaultText = "The default package from the syncpronote flake.";
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

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        WorkingDirectory = cfg.dataDir;
        ExecStartPre = "${preStartScript}";
        ExecStart = "${syncpronote-pkg}/bin/syncpronote";
        Restart = "on-failure";
      };
    };
  };
}
