{
  description = "A custom package for the syncpronote service.";

  outputs = { self, nixpkgs }:
  let
    supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
  in
  {
    packages = forAllSystems (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        nodeJs = pkgs.nodejs_20;
      in
      {
        default = pkgs.buildNpmPackage {
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
      }
    );

    nixosModules.default = ./service.nix;
  };
}
