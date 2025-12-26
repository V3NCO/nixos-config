{ ... }:
{
  services.fail2ban = {
    enable = true;
    maxretry = 10;
    ignoreIP = [
      "192.168.0.0/16"
      "100.71.229.69"
      "100.122.72.126"
    ];
    bantime = "8h";
    bantime-increment = {
      enable = true;
      rndtime = "30m";
      maxtime = "168h";
    };
    jails = {
      sshd.settings = {
        enabled = true;
        port = 222;
        mode = "aggressive";
      };
      dovecot.settings = {
        enabled = true;
        mode = "aggressive";
      };
      postfix.settings = {
        enabled = true;
        mode = "aggressive";
      };
    };
  };
}
