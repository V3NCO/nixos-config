{ config, ... }:
{
  systemd.services.traefik.serviceConfig.EnvironmentFile =
    "${config.services.traefik.dataDir}/cloudflare.env";

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
          http.tls = { };
        };
      };

      log = {
        level = "DEBUG";
        filePath = "${config.services.traefik.dataDir}/traefik.log";
        format = "json";
      };

      accessLog = {
        filePath = "${config.services.traefik.dataDir}/access.log";
        format = "json";
        filters = {
          statusCodes = [
            "200-299"
            "400-599"
          ];
        };
        bufferingSize = 0;
        fields.headers = {
          defaultMode = "drop";
          names = {
            User-Agent = "keep";
          };
        };
      };

      certificatesResolvers.letsencrypt = {
        acme = {
          email = "certificates@v3nco.dev";
          storage = "${config.services.traefik.dataDir}/acme.json";
          httpChallenge = {
            entryPoint = "web";
          };
        };
      };

      api.dashboard = true;
    };

    dynamicConfigOptions = {
      http = {
        routers = {
          traefik = {
            entryPoints = [ "websecure" ];
            rule = "Host(`traefik.amber.dog`)";
            service = "api@internal";
            tls.certResolver = "letsencrypt";
            middlewares = [
              "security-headers"
              "basic-auth"
            ];
          };

          zipline = {
            entryPoints = [ "websecure" ];
            rule = "Host(`zipline.v3nco.dev`)";
            service = "zipline";
            tls.certResolver = "letsencrypt";
            middlewares = [ "security-headers" ];
          };

          aperture-tts-slack = {
            entryPoints = [ "websecure" ];
            rule = "Host(`aperture-tts-slack.v3nco.dev`)";
            service = "aperture-tts-slack";
            tls.certResolver = "letsencrypt";
            middlewares = [ "security-headers" ];
          };

          synapse = {
            entryPoints = [ "websecure" ];
            rule = "Host(`synapse.v3nco.dev`)";
            service = "synapse";
            tls.certResolver = "letsencrypt";
            middlewares = [ "security-headers" ];
          };

          nexus = {
            entryPoints = [ "websecure" ];
            rule = "Host(`nexus.v3nco.dev`)";
            service = "nexus";
            tls.certResolver = "letsencrypt";
            middlewares = [ "security-headers" ];
          };

          forgejo = {
            entryPoints = [ "websecure" ];
            rule = "Host(`forgejo.v3nco.dev`)";
            service = "forgejo";
            tls.certResolver = "letsencrypt";
            middlewares = [ "security-headers" ];
          };
        };

        services = {
          zipline.loadBalancer.servers = [
            {
              url = "https://100.93.234.76";
            }
          ];
          aperture-tts-slack.loadBalancer.servers = [
            {
              url = "https://100.93.234.76";
            }
          ];
          synapse.loadBalancer.servers = [
            {
              url = "https://100.93.234.76";
            }
          ];
          nexus.loadBalancer.servers = [
            {
              url = "http+unix:///run/anubis/anubis-nexus/anubis.sock";
            }
          ];
          forgejo.loadBalancer.servers = [
            {
              url = "http+unix:///run/anubis/anubis-forgejo/anubis.sock";
            }
          ];
        };

        middlewares = {
          local-ipwhitelist.ipAllowList.sourceRange = [
            "192.168.0.0/16"
            "10.0.0.0/8"
            "127.0.0.1/32"
            "172.16.0.0/12"
            "100.0.0.0/8"
          ];
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
          rate-limit = {
            rateLimit = {
              average = 100;
              burst = 100;
              period = 1;
            };
          };
          basic-auth = {
            basicAuth = {
              usersFile = "${config.services.traefik.dataDir}/admindash.htpasswd";
            };
          };
        };
        serversTransports = {
          insecureTransport.insecureSkipVerify = true;
        };
      };

      tls = {
        options = {
          default = {
            sniStrict = false;
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
  };
}
