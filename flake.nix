{
  description = "Esther's config idk";

  nixConfig = {
    extra-substituters = [
      "https://nixos-apple-silicon.cachix.org"
      "https://nix-community.cachix.org"
      "https://niri.cachix.org"
      "https://walker.cachix.org"
      "https://walker-git.cachix.org"
      "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };


    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    nix-jetbrains-plugins.url = "github:nix-community/nix-jetbrains-plugins";

    # Hyperland Upstream
    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    # };

    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    # hyprgrass = {
    #   url = "github:horriblename/hyprgrass";
    #   inputs.hyprland.follows = "hyprland";
    # };
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

    quickshell-blur = {
      url = "github:bbedward/quickshell/ext-bg-effect";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qml-niri = {
      url = "github:imiric/qml-niri/main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    niri-flake.url = "github:sodiboo/niri-flake";
    elephant.url = "github:abenz1267/elephant";
    awww.url = "git+https://codeberg.org/LGFae/awww";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

    apple-silicon = {
      url = "github:nix-community/nixos-apple-silicon/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
    };

    dns = {
      url = "github:kirelagin/dns.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    streamcontroller = {
      url = "github:Daaboulex/streamcontroller-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    asahi-firmware = {
      url="/etc/nixos/firmware";
      flake = false;
    };
    syncpronote = {
      url = "./repos/syncpronote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, apple-silicon, ... }@inputs:
  {
    nixosConfigurations.quasar = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs { system = "x86_64-linux";
        config = {
          allowUnfree = true;
          android_sdk.accept_license = true;
          permittedInsecurePackages = [ "beekeeper-studio-5.3.4" ];
        };
      };

      specialArgs = {
        inherit inputs;
        quickshell = inputs.quickshell;
        unstable = import inputs.nixpkgs-unstable { system = "x86_64-linux";
          config = { allowUnfree = true; android_sdk.accept_license = true; };
        };
      };

      modules = [
        ./systems/quasar
        inputs.nixCats.nixosModules.default
        inputs.niri-flake.nixosModules.niri
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            sharedModules = [
              inputs.streamcontroller.homeManagerModules.default
              inputs.plasma-manager.homeModules.plasma-manager
            ];
            users = {
              venco = {
                imports = [
                  ./modules/home-manager/streamdeck
                  ./users/venco-home.nix
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
          android_sdk.accept_license = true;
          permittedInsecurePackages = [ "beekeeper-studio-5.3.4" ];
        };
      };

      specialArgs = {
        inherit inputs;
        quickshell = inputs.quickshell;
        unstable = import inputs.nixpkgs-unstable { system = "x86_64-linux";
          config = { allowUnfree = true; android_sdk.accept_license = true; };
        };
      };
      modules = [
        ./systems/comet
        inputs.nixCats.nixosModules.default
        inputs.niri-flake.nixosModules.niri
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            sharedModules = [
              inputs.plasma-manager.homeModules.plasma-manager
            ];
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
        inputs.nixCats.nixosModules.default
      ];
      specialArgs = {
        unstable = import inputs.nixpkgs-unstable { system = "x86_64-linux";
          config = { allowUnfree = true; android_sdk.accept_license = true; };
        };
      };
    };

    nixosConfigurations.sentinel = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
        unstable = import inputs.nixpkgs-unstable { system = "x86_64-linux";
          config = { allowUnfree = true; android_sdk.accept_license = true; };
        };
      };

      modules = [
        ./systems/sentinel
        inputs.nixCats.nixosModules.default
        ({ pkgs, _module, ... }: {
          imports = [ inputs.syncpronote.nixosModules.default ];
          _module.args.syncpronote-pkg = inputs.syncpronote.packages.${pkgs.stdenv.hostPlatform.system}.default;
        })
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

      specialArgs = {
        inherit inputs;
        quickshell = inputs.quickshell;
        unstable = import inputs.nixpkgs-unstable { system = "aarch64-linux";
          config = { allowUnfree = true; android_sdk.accept_license = true; };
        };
      };

      modules = [
        ./systems/stardust
        inputs.nixCats.nixosModules.default
        inputs.niri-flake.nixosModules.niri
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            backupFileExtension = "backup";
            useGlobalPkgs = true;
            useUserPackages = true;
            sharedModules = [
              inputs.plasma-manager.homeModules.plasma-manager
            ];
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
