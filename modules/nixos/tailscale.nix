{ config, pkgs, ... }:

{
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "client";  # or "server" or "both" depending on your use case
    };
}