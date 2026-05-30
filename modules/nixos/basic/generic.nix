{ pkgs, ... }:
{
  nix.settings.experimental-features = "nix-command flakes";

  environment.systemPackages = with pkgs; [
    wget
    btop
    fuzzel
    git
    nixd
    nil
    nixfmt-rfc-style
    exfat
    jq
  ];
  services.printing.enable = true;

  boot.blacklistedKernelModules = [ "algif_aead" ];
  # programs.bash.interactiveShellInit = ''eval "$(direnv hook bash)"'';
}
