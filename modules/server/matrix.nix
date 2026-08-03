{ config, ... }:
{
  # homelab.services.matrix = {
  #   subdomain = "matrix";
  #   zone = "blahaj";
  #   upstream = {
  #     scheme = "http";
  #     host = "127.0.0.1";
  #     port = config.services.matrix-conduit.settings.global.port;
  #   };
  #   middlewares = [ "security-headers" ];
  # };
  # homelab.ports = [ config.services.matrix-conduit.settings.global.port ];

  services.matrix-conduit = {
    enable = true;
    settings = {
      global = {
        port = 38923;
        server_name = "matrix.blahaj.engineering";
        enable_lightning_bolt = false;
        allow_check_for_updates = false;
        allow_federation = true;
      };
    };
  };
}
