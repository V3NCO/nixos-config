{ lib, config, pkgs, ... }:
{
  homelab.ports = [
    config.services.sharkey.settings.port
    config.services.hajdentity.frontend.port
    config.services.hajdentity.port
    3900
  ];

  homelab.services.hajdentity = {
    subdomain = "id";
    zone = "blahaj";
    upstream = {
      scheme = "http";
      host = "127.0.0.1";
      port = config.services.hajdentity.frontend.port;
    };
    middlewares = [ "security-headers" ];
  };

  homelab.services.sharkey = {
    subdomain = "social";
    zone = "blahaj";
    upstream = {
      scheme = "http";
      host = "127.0.0.1";
      port = config.services.sharkey.settings.port;
    };
    middlewares = [ "security-headers" ];
  };


  services.sharkey = {
    enable = true;
    settings = {
      address = "127.0.0.1";
      port = 3622;
      url = "https://social.blahaj.engineering/";
    };
  };

  services.hajdentity = {
    enable = true;
    adminEmail = "hajdentity@esther.tf";
    baseUrl = "https://id.blahaj.engineering/";
    systemId = "HAJ-PROD-MAIN";
    port = 6532;

    environmentFile = "/var/lib/hajdentity/.env";

    frontend = {
      enable = true;
      host = "127.0.0.1";
      port = 3000;
    };

    sharkey = {
      baseUrl = "http://127.0.0.1:${lib.toString config.services.sharkey.settings.port}";
      publicUrl = config.services.sharkey.settings.url;
    };

    s3 = {
      endpoint = "127.0.0.1:3900";
      bucket = "hajdentity";
      secure = false;
      region = "garage";
    };

    mail = {
      username = "noreply@v3nco.dev";
      fromAddress = "noreply@v3nco.dev";
      fromName = "Hajdentity";
      server = "smtp.purelymail.com";
    };
  };

  services.garage = {
    enable = true;
    package = pkgs.garage;

    environmentFile = "/var/lib/garage/secrets.env";

    settings = {
      metadata_dir = "/var/lib/garage/meta";
      data_dir = "/var/lib/garage/data";
      db_engine = "sqlite";

      replication_factor = 1;

      rpc_bind_addr = "[::]:3901";
      rpc_public_addr = "127.0.0.1:3901";

      s3_api = {
        api_bind_addr = "127.0.0.1:3900";
        s3_region = "garage";
        root_domain = ".s3.garage.localhost";
      };
    };
  };
}
