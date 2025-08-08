{pkgs, config, inputs, ...}:
{
  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages."${system}".twilight
  ];  
}