{ lib, ...}:
{
  security.soteria.enable = false;
  security.pam.sshAgentAuth.enable = true;
  services.gnome.gcr-ssh-agent.enable = lib.mkForce false;
}
