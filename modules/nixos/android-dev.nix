{ nixpkgs, ... }:
let
  pkgs = import nixpkgs {
    system = "x86_64-linux";
    config = {
      android_sdk.accept_license = true;
    };
  };
in
{
  imports = with pkgs; [
    android-studio-full
    android-tools
  ];
}
