{ config, lib, ... }:
let
  zones = {
    v3nco = { domain = "v3nco.dev"; };
    esther = { domain = "esther.tf"; };
  };

  defaults = {
    entryPoints = [ "websecure" ];
    middlewares = [ "security-headers" ];
    tlsCertResolver = "letsencrypt";
    serversTransport = "insecureTransport";
  };

  homelabServices = config.homelab.services or { };

  mkHostname = svc:
    if svc ? fqdn && svc.fqdn != null then
      svc.fqdn
    else
      "${svc.subdomain}.${zones.${svc.zone}.domain}";

  mkUpstreamUrl = svc: "${svc.upstream.scheme}://${svc.upstream.host}:${toString svc.upstream.port}";

  mkEntryPoints = svc:
    if svc ? entryPoints && svc.entryPoints != null then svc.entryPoints else defaults.entryPoints;

  mkMiddlewares = svc:
    if svc ? middlewares && svc.middlewares != null then svc.middlewares else defaults.middlewares;

  routersFromRegistry =
    lib.mapAttrs
      (name: svc: {
        entryPoints = mkEntryPoints svc;
        rule = "Host(`${mkHostname svc}`)";
        service = name;
        tls = { certResolver = defaults.tlsCertResolver; };
        middlewares = mkMiddlewares svc;
      })
      homelabServices;

  servicesFromRegistry =
    lib.mapAttrs
      (name: svc: {
        loadBalancer = {
          serversTransport = defaults.serversTransport;
          servers = [ { url = mkUpstreamUrl svc; } ];
        };
      })
      homelabServices;
in
{
  systemd.services.traefik.serviceConfig.EnvironmentFile =
    "${config.services.traefik.dataDir}/cloudflare.env";

  homelab.ports = [ 80 443 ];

  services.traefik = {
    enable = true;

    staticConfigOptions = {
      global.sendAnonymousUsage = false;

      entryPoints = {
        web = {
          address = ":80";
          asDefault = false;
          http.redirections.entrypoint = {
            to = "websecure";
            scheme = "https";
          };
        };

        websecure = {
          address = ":443";
          asDefault = true;
          http.tls = {
            certResolver = defaults.tlsCertResolver;
            domains = [
              { main = zones.v3nco.domain; sans = [ "*.${zones.v3nco.domain}" ]; }
              { main = zones.esther.domain; sans = [ "*.${zones.esther.domain}" ]; }
            ];
          };
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
          dnsChallenge = {
            provider = "cloudflare";
            resolvers = [ "1.1.1.1:53" "8.8.8.8:53" ];
          };
        };
      };

      api.dashboard = false;
    };

    dynamicConfigOptions = {
      http = {
        routers = routersFromRegistry;
        services = servicesFromRegistry;

        middlewares = {
          tinyauth.forwardauth.address = "https://tinyauth.v3nco.dev/api/auth/traefik";
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
              average = 5;
              burst = 20;
              period = 5;
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
