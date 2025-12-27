{ pkgs, inputs, ... }:
let
  webstormPlugins = [
    inputs.nix-jetbrains-plugins.plugins."${pkgs.system
    }".webstorm."2025.3"."com.wakatime.intellij.plugin"
    inputs.nix-jetbrains-plugins.plugins."${pkgs.system}".webstorm."2025.3"."dev.blachut.svelte.lang"
  ];
in
{
  environment.systemPackages = [
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.webstorm webstormPlugins)
  ];
}
