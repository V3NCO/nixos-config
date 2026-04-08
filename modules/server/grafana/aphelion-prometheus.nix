{ ... }:
{
  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 9090 ];
  services.prometheus = {
    enable = true;
    port = 9090;
    exporters.node = {
      enable = true;
      enabledCollectors = [ "systemd" ];
    };
    scrapeConfigs = [
      { job_name = "traefik"; static_configs = [{ targets = [ "127.0.0.1:8082" ]; }]; }
      { job_name = "anubis"; static_configs = [{ targets = [ "127.0.0.1:9099" ]; }]; metrics_path = "/metrics"; }
      { job_name = "node"; static_configs = [{ targets = [ "127.0.0.1:9100" ]; }]; }
    ];
  };
}
