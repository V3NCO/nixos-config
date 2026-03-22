{ lib, inputs, config, pkgs, ... }:
let
  dns = inputs.dns;

  util = dns.util.${pkgs.stdenv.hostPlatform.system};

  zones = {
    v3nco = { domain = "v3nco.dev"; };
    esther = { domain = "esther.tf"; };
  };

  sentinelHostLabel = "sentinel";
  sentinelTailscaleIp = config.homelab.dns.sentinelTailscaleIp;

  services = config.homelab.services;

  servicesForZone =
    zoneKey:
    lib.attrValues (lib.filterAttrs (_: svc: (svc.zone or "v3nco") == zoneKey) services);

  mkZone =
    zoneKey:
    let
      domain = zones.${zoneKey}.domain;
      sentinelFqdn = "${sentinelHostLabel}.${domain}.";
      svcs = servicesForZone zoneKey;
    in
    {
      SOA = {
        nameServer = sentinelFqdn;
        adminEmail = "hostmaster.${domain}";
        serial = config.homelab.dns.serial;
      };

      NS = [ sentinelFqdn ];

      subdomains =
        lib.listToAttrs (
          [
            {
              name = sentinelHostLabel;
              value = { A = [ sentinelTailscaleIp ]; };
            }
          ]
          ++ map
            (svc: {
              name = svc.subdomain;
              value = { CNAME = [ sentinelFqdn ]; };
            })
            svcs
        );
    };

  zoneFiles = {
    v3nco = util.writeZone zones.v3nco.domain (mkZone "v3nco");
    esther = util.writeZone zones.esther.domain (mkZone "esther");
  };
in
{
  options = {
    homelab = {
      dns = {
        serial = lib.mkOption {
          type = lib.types.int;
          default = 1;
          description = "Zone serial number for locally generated split-horizon zones.";
        };

        sentinelTailscaleIp = lib.mkOption {
          type = lib.types.str;
          default = "100.96.199.124";
          description = "Sentinel's Tailscale IPv4 address (100.x.y.z) used for split-horizon A records.";
        };

        zoneFiles = lib.mkOption {
          type = lib.types.attrsOf lib.types.path;
          readOnly = true;
          default = { };
          description = "Generated zone file paths, suitable for DNS daemons to load.";
        };
      };

      services = lib.mkOption {
        type =
          lib.types.attrsOf (lib.types.submodule ({ name, ... }: {
            options = {
              zone = lib.mkOption {
                type = lib.types.enum [ "v3nco" "esther" ];
                default = "v3nco";
                description = "Which base domain zone to use.";
              };

              subdomain = lib.mkOption {
                type = lib.types.str;
                default = name;
                description = "The subdomain label to publish within the selected zone.";
              };

              # Fields below are not used by DNS generation, but are here so Traefik can
              # consume the same registry (Option A from our discussion).
              fqdn = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
                description = "Optional explicit FQDN override (Traefik can use this). DNS generation ignores this.";
              };

              upstream = {
                scheme = lib.mkOption {
                  type = lib.types.enum [ "http" "https" ];
                  default = "http";
                  description = "Upstream scheme (for Traefik).";
                };

                host = lib.mkOption {
                  type = lib.types.str;
                  default = "127.0.0.1";
                  description = "Upstream host (for Traefik).";
                };

                port = lib.mkOption {
                  type = lib.types.int;
                  description = "Upstream port (for Traefik).";
                };
              };

              middlewares = lib.mkOption {
                type = lib.types.nullOr (lib.types.listOf lib.types.str);
                default = null;
                description = "Optional Traefik middlewares list.";
              };

              entryPoints = lib.mkOption {
                type = lib.types.nullOr (lib.types.listOf lib.types.str);
                default = null;
                description = "Optional Traefik entryPoints override.";
              };
            };
          }));
        default = { };
        description = "Shared registry of homelab services for DNS + Traefik generation.";
      };
    };
  };

  config = {
    homelab.dns.zoneFiles = zoneFiles;

    services.unbound = {
      enable = true;

      settings = {
        server = {
          interface = [
            "127.0.0.1"
            sentinelTailscaleIp
          ];

          access-control = [
            "127.0.0.0/8 allow"
            "100.64.0.0/10 allow"
          ];

          # Basic hardening.
          hide-identity = "yes";
          hide-version = "yes";
        };

        auth-zone = [
          {
            name = zones.v3nco.domain;
            zonefile = toString zoneFiles.v3nco;
          }
          {
            name = zones.esther.domain;
            zonefile = toString zoneFiles.esther;
          }
        ];
      };
    };
  };

}
