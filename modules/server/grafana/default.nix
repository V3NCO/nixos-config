{ config, pkgs, ... }:
{
  homelab = {
    ports = with config.services; [
      grafana.settings.server.http_port
      prometheus.port
      prometheus.exporters.node.port
    ];
    services.grafana = {
      subdomain = "grafana";
      zone = "v3nco";
      upstream = {
        scheme = "http";
        host = "127.0.0.1";
        port = config.services.grafana.settings.server.http_port;
      };
      middlewares = [
        "security-headers"
      ];
    };
  };

  services.grafana = {
    enable = true;
    settings.server.http_port = 9349;

    provision = {
      enable = true;
      datasources.settings.datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          access = "proxy";
          url = "http://127.0.0.1:9090";
        }
      ];
      dashboards.settings.providers = [
        {
          name = "My Dashboards";
          options.path = "/etc/grafana-dashboards";
        }
      ];
    };
  };

  services.prometheus = {
    enable = true;
    exporters.node = {
      enable = true;
      enabledCollectors = [ "systemd" ];
    };
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [{ targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ]; }];
      }
    ];
  };

  environment.etc."grafana-dashboards/node-exporter.json".source = ./node-exporter.json;
}
