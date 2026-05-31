{ inputs, pkgs, ... }:
{
  imports = [ inputs.streamcontroller.nixosModules.default ];

  programs.streamcontroller = {
    enable = true;
    autostart = true;
  };

  environment.systemPackages = [
    inputs.streamcontroller.packages.${pkgs.stdenv.hostPlatform.system}.streamcontroller-cli
  ];
}
