{ ... }:
{
homelab.services.radicale = {
  subdomain = "radicale";
  zone = "v3nco";
  upstream = {
    scheme = "http";
    host = "127.0.0.1";
    port = 5232;
  };

  homelab.ports = [ 5232 ];
  services.radicale = {
    enable = true;
    settings = {
      server = {
        hosts = [ "127.0.0.1:5232" ];
      };
      auth = {
        type = "htpasswd";
        htpasswd_filename = "/etc/radicale/users";
        htpasswd_encryption = "autodetect";
      };
      storage = {
        filesystem_folder = "/var/lib/radicale/collections";
      };
    };
  }
}
