{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    restic
  ];


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
        repository = "sftp:sentinel@100.89.108.16:/Backup-Sentinel/restic";
      };
    };
  };
}
