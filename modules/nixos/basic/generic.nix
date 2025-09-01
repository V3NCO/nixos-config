{ pkgs, ... }:
{
  nix.settings.experimental-features = "nix-command flakes";

  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    btop
    alacritty
    fuzzel
    git
    alacritty
    nixd
    nil
    nixfmt-rfc-style
    kdePackages.full
  ];

  programs.bash.interactiveShellInit = ''eval "$(direnv hook bash)"'';
}
