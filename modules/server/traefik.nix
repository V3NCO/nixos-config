{ config, ... }:
{
    systemd.services.traefik.environment = {
      CF_DNS_API_TOKEN_FILE = "${config.services.traefik.dataDir}/CF_API_TOKEN";
    };
    services.traefik = {
      enable = true;
        staticConfigOptions = {
          global.sendAnonymousUsage = false;

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
                    sans = [ "*.amber.dog" ];
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

          accessLog = {
            filePath = "${config.services.traefik.dataDir}/access.log";
            format = "json";
            filters = {
              statusCodes = [ "200-299" "400-599" ];
            };
            bufferingSize = 0;
            fields.headers = {
              defaultMode = "drop";
              names = {
                User-Agent = "keep";
              };
            };
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
            http.routers = {
              traefik = {
                entryPoints = [ "websecure" ];
                rule = "Host(`traefik.amber.dog`)";
                service = "api@internal";
                tls = true;
                middlewares = [ "security-headers" "basic-auth" ];
              };
            };
            http.services = {};
            http.serversTransports = {
              insecureTransport.insecureSkipVerify = true;
            };
            http.middlewares = {
              local-ipwhitelist.ipAllowList.sourceRange = [ "192.168.0.0/16" "10.0.0.0/8" "127.0.0.1/32" "172.16.0.0/12" "100.0.0.0/8" ];
              security-headers.headers = {
                customResponseHeaders = {
                  Server = "";
                  X-Powered-By = "";
                  X-Forwarded-Proto = "https";
                };
                sslProxyHeaders = {
                  X-Forwarded-Proto = "https";
                };
                hostsProxyHeaders = [ "X-Forwarded-For" ];
                contentTypeNosniff = true;
                customFrameOptionsValue = "SAMEORIGIN";
                browserXssFilter = false;
                referrerPolicy = "strict-origin-when-cross-origin";
                forceSTSHeader = true;
                stsIncludeSubdomains = true;
                stsSeconds = 63072000;
                stsPreload = true;
              };
              rate-limit.rateLimit = {
                average = 100;
                burst = 100;
                period = 1;
              };
              basic-auth.basicAuth.usersFile = "${config.services.traefik.dataDir}/admindash.htpasswd";
            tls.options.default = {
              sniStrict = true;
              minVersion = "VersionTLS12";
              cipherSuites = [
                "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256"
                "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
                "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384"
                "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384"
                "TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305"
                "TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305"
              ];
            };
        };
    };
  };
}
