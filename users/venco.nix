{pkgs, ...}:
{
  users.users.venco = {
    isNormalUser = true;
    description = "Venco";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "password";
    packages = with pkgs; [
      # Yubikey and Tor
      tor-browser
      yubikey-personalization
      yubikey-manager
      yubikey-touch-detector
      yubioath-flutter
      yubikey-personalization-gui

      thunderbird
      discord
      vesktop
      slack
      signal-desktop-bin
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
      dnsutils  # `dig` + `nslookup`
      ldns # replacement of `dig`, it provide the command `drill`
      aria2 # A lightweight multi-protocol & multi-source command-line download utility
      socat # replacement of openbsd-netcat
      nmap # A utility for network discovery and security auditing
      ipcalc  # it is a calculator for the IPv4/v6 addresses

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

      btop  # replacement of htop/nmon
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
    ];
  };

  programs.gpu-screen-recorder.enable = true; # For promptless recording on both CLI and GUI

    environment.systemPackages = with pkgs; [
      gpu-screen-recorder-gtk # GUI app
    ];

  imports = [
    ../modules/nixos/browsers
    ../modules/nixos/tailscale.nix
    ../modules/nixos/editors
    ../modules/nixos/steam.nix
  ];
}
