{pkgs, config, ...}:
{
  services.pcscd.enable = true;
  hardware.gpgSmartcards.enable = true;
}
