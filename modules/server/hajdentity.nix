{ lib, config, pkgs, ... }:
{
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
    adminEmail = "noreply@v3nco.dev";
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
