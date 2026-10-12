{ unstable, ... }:
{
  environment.systemPackages = [
    unstable.wheelwizard
    unstable.dolphin-emu
    unstable.pcsx2
    unstable.hydralauncher
    unstable.nero-umu
    unstable.bottles
  ];
}
