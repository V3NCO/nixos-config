{
  inputs,
  pkgs,
  lib,
  ...
}:

{
  # Pull in the upstream Home Manager module when the flake input exists.
  imports = lib.optional (inputs ? vicinae) inputs.vicinae.homeManagerModules.default;

  # Sane defaults that remain easy to override in user/host configs.
  services.vicinae = {
    enable = lib.mkDefault true;
    autoStart = lib.mkDefault true;
    package = inputs.vicinae.packages.${pkgs.system}.default;
  };
}
