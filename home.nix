{ config, pkgs, inputs, ... }:
{
  home.username = "venco";
  home.homeDirectory = "/home/venco";
  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Venco";
    userEmail = "v3nco@v3nco.dev";
    signing.signByDefault = true;
    signing.key = "6FAA8732F6512AAD6EDC522AE5E0FA4E59297845";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };


  
  

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # set some aliases, feel free to add more or remove some
  };

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
  ];
};

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
