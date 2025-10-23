{ config, ... }:
{
    environment.variables = {
      CF_DNS_API_TOKEN_FILE = "${config.services.traefik.dataDir}/CF_API_TOKEN";
    };
    services.traefik = {
      enable = true;
        staticConfigOptions = {
          entryPoints = {
            web = {
              address = ":80";
              asDefault = true;
              http.redirections.entrypoint = {
                  to = "websecure";
                  scheme = "https";
              };
            };

            websecure = {
              address = ":443";
              asDefault = true;
              http.tls = {
                certResolver = "cfacme";
                domains = [
                  {
                    main = "v3nco.dev";
                    sans = [ "*.v3nco.dev" ];
                  }
                  {
                    main = "amber.dog";
                    sans = [ "*.amber.dog" ]
                  }
                ];
              };
            };
          };

          log = {
            level = "INFO";
            filePath = "${config.services.traefik.dataDir}/traefik.log";
            format = "json";
          };

          certificatesResolvers.cfacme.acme = {
            email = "certificates@v3nco.dev";
            storage = "${config.services.traefik.dataDir}/acme.json";
            dnsChallenge = {
              provider = "cloudflare";
              resolvers = [ "1.1.1.1:53" "1.0.0.1:53" ];
            };
          };

          api.dashboard = true;
          # Access the Traefik dashboard on <Traefik IP>:8080 of your server
          # api.insecure = true;
        };

        dynamicConfigOptions = {
            http.routers = {};
            http.services = {};
        };
    };
}
