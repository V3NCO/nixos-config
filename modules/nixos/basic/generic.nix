{ pkgs, ... }:
{
  nix.settings = {
    experimental-features = "nix-command flakes";
    accept-flake-config = true;
    substituters = [
      "https://nixos-apple-silicon.cachix.org"
      "https://nix-community.cachix.org"
      "https://niri.cachix.org"
      "https://walker.cachix.org"
      "https://walker-git.cachix.org"
      "https://noctalia.cachix.org"
    ];
    trusted-public-keys = [
      "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
    btop
    fuzzel
    git
    nixd
    nil
    nixfmt
    exfat
    jq
  ];
  services.printing.enable = true;

  environment.enableAllTerminfo = true;
  boot.blacklistedKernelModules = [ "algif_aead" ];
  # programs.bash.interactiveShellInit = ''eval "$(direnv hook bash)"'';
}
