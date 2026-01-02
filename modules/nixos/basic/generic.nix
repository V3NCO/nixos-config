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
  ];
  services.printing.enable = true;
  # programs.bash.interactiveShellInit = ''eval "$(direnv hook bash)"'';
}
