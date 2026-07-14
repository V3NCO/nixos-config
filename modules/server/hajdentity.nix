{ lib, config, pkgs, ... }:
{
  # Expose internal service ports to your homelab routing
  homelab.ports = [
    config.services.sharkey.settings.port
    config.services.hajdentity.frontend.port
    config.services.hajdentity.port
    3900                                     # Garage S3 API
  ];

  services.sharkey = {
    enable = true;
    settings = {
      address = "127.0.0.1";
      port = 3622;
      url = "https://sharkey.v3nco.dev/";
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
