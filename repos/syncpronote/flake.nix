{
  description = "A Nix flake for the syncpronote project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        nodeJs = pkgs.nodejs_20;
      in
      {
        packages.default = pkgs.buildNpmPackage {
          pname = "syncpronote";
          version = "1.3.0";

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

        devShells.default = pkgs.mkShell {
          buildInputs = [
            nodeJs
            pkgs.nodePackages.npm
          ];
        };
      });
}