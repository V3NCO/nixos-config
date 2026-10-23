{ pkgs, inputs, ... }:

let
  webstormPlugins = [
    inputs.nix-jetbrains-plugins.plugins."${pkgs.stdenv.hostPlatform.system
    }".webstorm."2026.2"."com.wakatime.intellij.plugin"
    inputs.nix-jetbrains-plugins.plugins."${pkgs.stdenv.hostPlatform.system}".webstorm."2026.2"."dev.blachut.svelte.lang"
  ];
in

{
  environment.systemPackages = [
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.webstorm webstormPlugins)
  ];
}
