{ pkgs, inputs, ... }:

let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };

  webstormPlugins = [
    inputs.nix-jetbrains-plugins.plugins."${pkgs.system
    }".webstorm."2025.3"."com.wakatime.intellij.plugin"
    inputs.nix-jetbrains-plugins.plugins."${pkgs.system}".webstorm."2025.3"."dev.blachut.svelte.lang"
  ];
in

{
  environment.systemPackages = [
    (unstable.jetbrains.plugins.addPlugins unstable.jetbrains.webstorm webstormPlugins)
  ];
}
