{ ... }:
{
  imports = [
    ../../modules/server/vm
    ./syncthing.nix
    ../../modules/server/port-conflicts.nix
    ../../modules/server/immich.nix
    ../../modules/server/vaultwarden.nix
    ../../modules/server/forgejo.nix
    ../../modules/server/radicale.nix
    ../../modules/server/auth.nix
    ../../modules/server/paperless-ngx.nix
    ../../modules/server/nextcloud.nix
    ../../modules/server/homebox.nix
    ../../modules/server/syncpronote.nix
    ../../modules/server/grafana
    ../../modules/server/music
  ];

  system.activationScripts.shared-acl = {
    text = ''
      chown syncthing:music /shared || true
      chmod 2770 /shared || true
      setfacl -R -m g:music:rwx /shared || true
      setfacl -R -m m::rwx /shared || true
      setfacl -R -d -m g:music:rwx /shared || true
      setfacl -R -d -m m::rwx /shared || true
      find /shared -type d -exec chmod g+s {} \; || true
    '';
  };
}
