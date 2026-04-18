# /home/venco/nixos-config/pkgs/syncpronote/flake.nix
{
  description = "A custom package for the syncpronote service.";

  # No inputs needed here, as they are provided by the top-level flake.

  outputs = { self, nixpkgs }:
  let
    system = nixpkgs.system;
    pkgs = nixpkgs.legacyPackages.${system};
    nodeJs = pkgs.nodejs_20;
  in
  {
    packages.${system}.default = pkgs.buildNpmPackage {
      pname = "syncpronote";
      version = "1.3.0";

      # The source is now the directory containing this flake.nix
      src = ./.;

      npmDepsHash = "sha256-sQAgK0jDpG/FAs9kdDH8Mczsh9PuYaMStrIZ34csa9U=";
      dontNpmBuild = true;

      installPhase = ''
        runHook preInstall
        mkdir -p $out/bin
        cp -r ./* $out/
        makeWrapper ${nodeJs}/bin/node $out/bin/syncpronote \
          --add-flags "$out/index.js"
        runHook postInstall
      '';

      meta = with pkgs.lib; {
        description = "A tool to synchronize Pronote calendar to another calendar service.";
        homepage = "https://github.com/johan-perso/syncpronote";
        license = licenses.mit;
      };
    };

    # We still expose the NixOS module as before.
    nixosModules.default = ./service.nix;
  };
}
