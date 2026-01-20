{
  pkgs,
  lib,
  ...
}:
{
  users.users.venco = {
    isNormalUser = true;
    description = "Venco";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "input"
    ];
    openssh.authorizedKeys.keys = [
      # Stardust SSH Key
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBONQ8znwJEINzYqw077cPeQGdxuNojS1q8v2PXFbv3hFPCWEgv+Z8J+xOQHJXDaM+48Bd8g67QkKADxQtFkJHak= v3nco@v3nco.dev"
      # Sentinel SSH
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHFDwAnZIKGTxA8g0o0sQ54WP9ZCLeACy8OHrLG8OADNAAAABHNzaDo="
      # Guardian GPG
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3PiNEseKdDtTl84l6I5j7Mp5zrbRAOvJtIOHfQ1eBXQ+UP4+JD9BkxedRoAO4MFt9aHGUcy1zGEf6mouStjTcMLstpIFGG6pnMMJsFqXg+2tMBePNVGloefVkPjcCekVauTZV51Rr/rQhMLaQZzjf+CicT+/P2xPbE+6RLKwmgFxc0ChAJF4giRiDkF87zGxmuQE219IbCfBTO2dl94RvMXKGUufAJWKu+vi63fXxCVje3WBj/KtntL91aZqE4pgyuis4l9kLzL5hyKeDcM4EvEyimkX4MHDO7YwJlchCRcs1wo18i6/waC3QKYKL7Kgt+BY9Th81qJ5iAwuappotp4ssEo0N8+GxebbMYP6qi7CcsleFcGQSlzmVw2q5K64uCJ+hvI1EE0jPBXCQlJAc5NQtvsR6+FYBWZ/F87i+7y8nn3dWw1KOwXKlKiPlNI5Fn6a5NtQ20tSgyiMQFRQ30ZOwsUFvgoMKTjtsQMEaqljqo0b7L0AOsTyfAXPtY2UQtTxQYzZ7G5wxJIu6eIe8Slisa1T4XHoQGaoF9MWK/v97kYnud9Cp+jhdmlckV7fwyTb2JLF8W4IDsRA7qEgb1p/ERuRarhIkXtjb1FiXF6I+tOKhEPdzy3X9zoiP+SXuE9NzchWHZ59Mr08ZRXaV0s9XkKFRU8y7VwaOc+RSSQ== openpgp:0x148001EA"
    ];
    initialPassword = "password";
    packages = with pkgs; [
      # Yubikey and Tor
      tor-browser
      yubikey-personalization
      yubikey-manager
      yubikey-touch-detector
      yubioath-flutter

      thunderbird
      discord
      vesktop
      slack
      zoom-us
      signal-desktop-bin
      mattermost-desktop
      spotify

      neofetch
      fastfetch
      hyfetch
      nnn # terminal file manager

      # archives
      zip
      xz
      unzip
      p7zip

      # utils
      ripgrep # recursively searches directories for a regex pattern
      jq # A lightweight and flexible command-line JSON processor
      yq-go # yaml processor https://github.com/mikefarah/yq
      eza # A modern replacement for ‘ls’
      fzf # A command-line fuzzy finder
      nodejs_24

      # networking tools
      mtr # A network diagnostic tool
      iperf3
      dnsutils # `dig` + `nslookup`
      ldns # replacement of `dig`, it provide the command `drill`
      aria2 # A lightweight multi-protocol & multi-source command-line download utility
      socat # replacement of openbsd-netcat
      nmap # A utility for network discovery and security auditing
      ipcalc # it is a calculator for the IPv4/v6 addresses

      # misc
      file
      which
      tree
      gnused
      gnutar
      gawk
      zstd

      # nix related
      #
      # it provides the command `nom` works just like `nix`
      # with more details log output
      nix-output-monitor
      glow # markdown previewer in terminal

      btop # replacement of htop/nmon
      iotop # io monitoring
      iftop # network monitoring

      # system call monitoring
      strace # system call monitoring
      ltrace # library call monitoring
      lsof # list open files

      # system tools
      sysstat
      lm_sensors # for `sensors` command
      ethtool
      pciutils # lspci
      usbutils # lsusb

      playerctl
      killall
      clipse
      bash
      godot
      godot-mono
      aseprite # I bought it on steam anyways its just convinient to have as a package
      bitwarden-cli
      sc-controller
      blender
      virt-manager

      vlc
      yt-dlp
      ffmpeg
      krita

      heroic-unwrapped
      # itch
      # itch-dl

      affine-bin
      obsidian
      anytype

      android-tools
      swappy
      hyprshot
      ledger-live-desktop

      osu-lazer-bin
      prismlauncher
      remmina
      owmods-cli
      owmods-gui
      ryubing

      inotify-tools
      wakatime-cli
      r2modman
      yaak

      libreoffice-qt-fresh
      hunspell
      hunspellDicts.en_US
      hunspellDicts.fr-any

      via
    ];
  };

  boot.supportedFilesystems = [ "ntfs" ];

  imports = [
    ../modules/nixos/browsers
    ../modules/nixos/tailscale.nix
    ../modules/nixos/editors
    # ../modules/nixos/direnv.nix
  ];
}
