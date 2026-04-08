{ ... }:
{
  imports = [
    ../../modules/server/vm
    ../../modules/server/port-conflicts.nix
    ../../modules/server/immich.nix
    ../../modules/server/vaultwarden.nix
    ../../modules/server/forgejo.nix
    ../../modules/server/radicale.nix
    ../../modules/server/auth.nix
    ../../modules/server/paperless-ngx.nix
    ../../modules/server/grafana.nix
  ];
}
