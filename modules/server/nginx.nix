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
    };
  };
}
