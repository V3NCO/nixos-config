{ lib, ... }:
{
  options.homelab.tailscale = {
    ip = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "100.93.234.76";
      description = ''
        Tailscale-assigned IPv4 address for this host, exposed in a stable location
        so other modules can reference it (e.g. local DNS zone generation).

        Set this explicitly per-host. It is intentionally not auto-detected at eval-time.
      '';
    };
  };

  config = {
    services.tailscale.enable = true;
  };
}
