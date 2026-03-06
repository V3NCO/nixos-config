{ pkgs, ... }:
{
  systemd.services.pull-updates = {
    description = "Pulls changes to system config";
    restartIfChanged = false;
    onSuccess = [ "rebuild.service" ];
    startAt = "01:30";
    path = [pkgs.git pkgs.openssh];
    script = ''
      test "$(git branch --show-current)" = "master"
      git pull --ff-only
    '';
    serviceConfig = {
      WorkingDirectory = "/home/venco/nixos-config";
      User = "venco";
      Type = "oneshot";
    };
  };

  systemd.services.rebuild = {
    description = "Rebuilds and activates system config";
    restartIfChanged = false;
    path = [pkgs.nixos-rebuild pkgs.systemd pkgs.git pkgs.openssh];
    script = ''
      git config --global --add safe.directory /home/venco/nixos-config
      nixos-rebuild boot --flake /home/venco/nixos-config
      booted="$(readlink /run/booted-system/{initrd,kernel,kernel-modules})"
      built="$(readlink /nix/var/nix/profiles/system/{initrd,kernel,kernel-modules})"

      if [ "''${booted}" = "''${built}" ]; then
        nixos-rebuild switch --flake /home/venco/nixos-config
      else
        reboot now
      fi
    '';
    serviceConfig ={
      User = "root";
      Type = "oneshot";
    };
  };
}
