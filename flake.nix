{
  description = "A template that shows all standard flake outputs";

  # Inputs
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html#flake-inputs
  nixConfig = {
    extra-substituters = [ "https://hyprland.cachix.org" ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
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
    # caelestia-shell = {
      # url = "github:caelestia-dots/shell";
      # inputs.nixpkgs.follows = "nixpkgs";
    # };

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

    catppuccin.url = "github:catppuccin/nix/release-25.05";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    sys = "aarch64-linux";
  in {
    nixosConfigurations.stardust = nixpkgs.lib.nixosSystem {
      system = sys;

      pkgs = import inputs.nixpkgs { system = sys;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "beekeeper-studio-5.3.4" ];
        };
        overlays = [
          (final: prev: let isX86 = prev.stdenv.hostPlatform.system == "x86_64-linux"; in {
            gpu-screen-recorder = if isX86 then prev.gpu-screen-recorder else prev.stdenv.mkDerivation {
              name = "gpu-screen-recorder-stub";
              phases = [ "installPhase" ];
              installPhase = ''
                mkdir -p $out/bin
                echo '# stub' > $out/bin/gpu-screen-recorder
                chmod +x $out/bin/gpu-screen-recorder
              '';
            };
            gpu-screen-recorder-gtk = if isX86 then prev.gpu-screen-recorder-gtk else prev.stdenv.mkDerivation {
              name = "gpu-screen-recorder-gtk-stub";
              phases = [ "installPhase" ];
              installPhase = ''
                mkdir -p $out/bin
                echo '# stub' > $out/bin/gpu-screen-recorder-gtk
                chmod +x $out/bin/gpu-screen-recorder-gtk
              '';
            };
          })
        ];
      };

      # pass the firmware directory only if it exists (avoids adding a missing path to the flake closure)
      specialArgs = let
        fw = if builtins.pathExists ./systems/stardust/firmware then ./systems/stardust/firmware else null;
      in { inherit inputs; quickshell = inputs.quickshell; firmware = fw; };
      
      modules = [
        ./systems/stardust
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
              hostname="stardust";
            };
          };             
        }
      ];
    };

    nixosConfigurations.comet = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
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
  };
}
