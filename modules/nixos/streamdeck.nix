{ inputs, ... }:
{
  imports = [ inputs.streamcontroller.nixosModules.default ];

  programs.streamcontroller = {
    enable = true;
    autostart = true;
  };
}
