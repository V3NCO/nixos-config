{ lib, pkgs, ... }:
{
  # install beekeeper-studio as a system package
  environment.systemPackages = with pkgs; [
    beekeeper-studio
  ];

  # if you meant to enable some service/option, replace the above with the correct option name
}
