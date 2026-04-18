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

            sed -i 's|path.join(__dirname, ".config"|path.join(process.cwd(), ".config"|g' index.js
            sed -i 's|path.join(__dirname, "..", ".config"|path.join(process.cwd(), ".config"|g' utils/ntfy.js cli/auth-pronote.js cli/auth-google.js 2>/dev/null || true
            sed -i "s|path.join(__dirname, '..', '.config'|path.join(process.cwd(), '.config'|g" utils/icalendar.js 2>/dev/null || true
            sed -i 's|require("./utils/classnames")|require("fs").existsSync(require("path").join(process.cwd(), "utils/classnames.js")) ? require(require("path").join(process.cwd(), "utils/classnames.js")) : require("./utils/classnames")|g' index.js
            sed -i 's|require("./utils/custom-hours")|require("fs").existsSync(require("path").join(process.cwd(), "utils/custom-hours.js")) ? require(require("path").join(process.cwd(), "utils/custom-hours.js")) : require("./utils/custom-hours")|g' index.js

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
