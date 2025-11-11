{ inputs, ... }:
{
  imports = [
    (import "${inputs.caelestia-shell}/nix/hm-module.nix" inputs.caelestia-shell)
  ];

  programs.caelestia = {
    enable = true;
    cli.enable = true;
  };
}
