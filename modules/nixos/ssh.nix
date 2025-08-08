{pkgs, config, ...}:
{
  programs.ssh = {
    extraConfig = ''
    IdentityAgent none
    '';
  };
}