{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    restic
    cifs-utils
  ];

  fileSystems."/mnt/synology-backups" = {
        device = "//&lt;100.89.108.16&gt;/Backup-Sentinel";
        fsType = "cifs";
        options = let
          automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

        in &#91;"${automount_opts},credentials=/etc/nixos/smb-secrets"];
    };

  services.restic = {
    backups = let
      initialize = true;
      exclude = [
        "/home/*/.cache"
        "*.log"
      ];
      paths = [
        "/var/lib"
        "/etc"
        "/home"
        "/root"
      ];
      checkOpts = [
        "--with-cache"
      ];
      extraBackupArgs = [
      ];
      extraOptions = [
      ];
      passwordFile = "/var/lib/restic/password";
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
        "--keep-yearly 10"
      ];
      timerConfig = {
        OnBootSec = "3m";
        OnCalendar = "daily";
        Persistent = true;
      };
    in {
      backup = {
        inherit initialize exclude paths timerConfig checkOpts extraBackupArgs extraOptions passwordFile pruneOpts;

        environmentFile = "/var/lib/restic/.env";
        repository = "/mnt/synology-backups/restic";
      };
    };
  };
}
