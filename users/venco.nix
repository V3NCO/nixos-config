{config, pkgs, ...}:
{
  users.users.venco = {
    isNormalUser = true;
    description = "Venco";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "password";
    packages = with pkgs; [ 
      # using home manager 
    ];
  };
}