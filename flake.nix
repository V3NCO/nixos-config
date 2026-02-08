{
  description = "A template that shows all standard flake outputs";

  # Inputs
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html#flake-inputs
  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://nixos-apple-silicon.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    nix-jetbrains-plugins.url = "github:nix-community/nix-jetbrains-plugins";

    # Hyperland Upstream
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    # Lets start having fun with versions
    hm-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix/release-25.11";

    apple-silicon = {
      url = "github:nix-community/nixos-apple-silicon/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    asahi-firmware = {
      url="/etc/nixos/firmware";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, apple-silicon, ... }@inputs:
  {
    nixosConfigurations.quasar = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs { system = "x86_64-linux";
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "beekeeper-studio-5.3.4" ];
        };
      };

      specialArgs = { inherit inputs; quickshell = inputs.quickshell; };

      modules = [
        ./systems/quasar
        inputs.catppuccin.nixosModules.catppuccin
        inputs.nixCats.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            users = {
              venco = {
                imports = [
                  ./users/venco-home.nix
                  inputs.catppuccin.homeModules.catppuccin
                ];
              };
            };
            extraSpecialArgs = {
              inherit inputs;
              quickshell = inputs.quickshell;
              hostname = "quasar";
            };
          };
        }
      ];
    };

    nixosConfigurations.comet = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs { system = "x86_64-linux";
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "beekeeper-studio-5.3.4" ];
        };
      };

      specialArgs = { inherit inputs; quickshell = inputs.quickshell; };
      modules = [
        ./systems/comet
        inputs.catppuccin.nixosModules.catppuccin
        inputs.nixCats.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            users = {
              venco = {
                imports = [
                  ./users/venco-home.nix
                  inputs.catppuccin.homeModules.catppuccin
                ];
              };
            };
            extraSpecialArgs = {
              inherit inputs;
              quickshell = inputs.quickshell;
              hostname = "comet";
            };
          };
        }
      ];
    };

    nixosConfigurations.aphelion = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./systems/aphelion
      ];
    };

    nixosConfigurations.stardust = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";

      pkgs = import inputs.nixpkgs { system = "aarch64-linux";
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "beekeeper-studio-5.3.4" ];
        };
      };

      specialArgs = { inherit inputs; quickshell = inputs.quickshell; };

      modules = [
        ./systems/stardust
        inputs.nixCats.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            users = {
              venco = {
                imports = [
                  ./users/venco-home.nix
                ];
              };
            };
            extraSpecialArgs = {
              inherit inputs;
              quickshell = inputs.quickshell;
              hostname = "stardust";
            };
          };
        }
      ];
    };
  };
}
