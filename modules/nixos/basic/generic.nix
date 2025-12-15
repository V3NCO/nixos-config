{ pkgs, ... }:
{
  nix.settings.experimental-features = "nix-command flakes";

  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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
