{ ... }:
{
  services.fail2ban = {
    enable = true;
    bantime = "8h";
    bantime-increment = {
      enable = true;
      rndtime = "30m";
      maxtime = "168h";
    };
    jails = {
      sshd.settings = {
        enabled = true;
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
