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
          proxyPass = "http://100.93.234.76";
        };
      };
    };
  };
}
