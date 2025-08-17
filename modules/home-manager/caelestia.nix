{ inputs, ... }:
let
  caelestia-shell = inputs.caelestia-shell.packages."x86_64-linux".default.override {
    withCli = true;
  };
in
{
  home.packages = [
    caelestia-shell
  ];
}
