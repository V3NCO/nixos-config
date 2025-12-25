{ ... }:
{
  security.acme.defaults.email = "certificates@v3nco.dev";
  security.acme.acceptTerms = true;
  services.nginx = {
    enable = true;
    virtualHosts = {
      "zipline.v3nco.dev" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "https://100.93.234.76";
          extraConfig = ''
            proxy_ssl_server_name on;
            proxy_ssl_name $host;
            proxy_ssl_verify off;
          '';
        };
      };
      "aperture-tts-slack.v3nco.dev" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "https://100.93.234.76";
          extraConfig = ''
            proxy_ssl_server_name on;
            proxy_ssl_name $host;
            proxy_ssl_verify off;
          '';
        };
      };
      # Using Anubis, check the "nexus" instance in anubis.nix
      "nexus.v3nco.dev" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "/run/anubis/anubis-nexus.sock";
          extraConfig = ''
            proxy_ssl_server_name on;
            proxy_ssl_name $host;
            proxy_ssl_verify off;
          '';
        };
      };
      "synapse.v3nco.dev" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "https://100.93.234.76";
          extraConfig = ''
            proxy_ssl_server_name on;
            proxy_ssl_name $host;
            proxy_ssl_verify off;
          '';
        };
      };
      # Using Anubis, check the "forgejo" instance in anubis.nix
      "forgejo.v3nco.dev" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "/run/anubis/anubis-forgejo.sock";
          extraConfig = ''
            proxy_ssl_server_name on;
            proxy_ssl_name $host;
            proxy_ssl_verify off;
          '';
        };
      };
    };
  };
}
