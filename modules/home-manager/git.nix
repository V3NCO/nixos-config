{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Venco";
    userEmail = "v3nco@v3nco.dev";
    signing.signByDefault = true;
    signing.key = "6FAA8732F6512AAD6EDC522AE5E0FA4E59297845";
  };
}
