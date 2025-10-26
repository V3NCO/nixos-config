{ ... }:
{
  services.nginx = {
    enable = true;
    virtualHosts = {
      "zipline.v3nco.dev" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
            proxyPass = "http://sentinel";
          };
        };
      };
    };
  };
}
