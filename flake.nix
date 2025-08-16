{
  description = "A template that shows all standard flake outputs";

  # Inputs
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html#flake-inputs

  inputs = {
    # Nixpkgs Repo on github at version 25.05
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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

    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    apple-fonts.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      hm-unstable,
      quickshell,
      zen-browser,
      apple-fonts,
      ...
    }@inputs:
    {
      nixosConfigurations.quasar = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs quickshell; };
        modules = [
          ./systems/quasar
          ./modules/quickshell.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                venco = import ./users/venco-home.nix;
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
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              backupFileExtension = "backup";
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                venco = import ./users/venco-home.nix;
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
