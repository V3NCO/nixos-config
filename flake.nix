{
  description = "A template that shows all standard flake outputs";

  # Inputs
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html#flake-inputs

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
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

    catppuccin.url = "github:catppuccin/nix/release-25.05";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixpkgs-unstable,
      hm-unstable,
      quickshell,
      zen-browser,
      apple-fonts,
      catppuccin,
      ...
    }@inputs:
    {
      nixosConfigurations.quasar = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs quickshell; };
        modules = [
          ./systems/quasar
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                venco = {
                  imports = [
                    ./users/venco-home.nix
                    catppuccin.homeModules.catppuccin
                  ];
                };
              };
              extraSpecialArgs = {
                inherit inputs;
                inherit quickshell;
                hostname = "quasar";
              };
            };
          }
        ];
      };

      nixosConfigurations.comet = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs quickshell; };
        modules = [
          ./systems/comet
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              backupFileExtension = "backup";
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                venco = {
                  imports = [
                    ./users/venco-home.nix
                    catppuccin.homeModules.catppuccin
                  ];
                };
              };
              extraSpecialArgs = {
                inherit inputs;
                inherit quickshell;
                hostname = "comet";
              };
            };
          }
        ];
      };
    };
}
