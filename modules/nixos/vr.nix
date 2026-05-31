{ lib, pkgs, ... }:
{
  services.wivrn = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    wayvr
    android-tools
    bs-manager
  ];

  programs.steam.package = lib.mkDefault (
    pkgs.steam.override (prev: {
      extraEnv =
      {
        PRESSURE_VESSEL_FILESYSTEMS_RW = "$XDG_RUNTIME_DIR/wivrn/comp_ipc";
      }
      // (prev.extraEnv or {});
    })
  );
}
