{config, pkgs, ...}:
{
    programs.zed-editor = {
        enable = true;
        extensions = ["nix" "wakatime"];
    }
}