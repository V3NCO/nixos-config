{ inputs, ... }:
{
  imports = [
    inputs.streamcontroller.homeManagerModules.default
  ];

  programs.streamcontroller = {
    enable = true;
  };
}
