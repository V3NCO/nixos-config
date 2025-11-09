{ pkgs, ... }:
{
  users.users.venco = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    openssh.authorizedKeys.keys = [
      # Stardust SSH Key
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBONQ8znwJEINzYqw077cPeQGdxuNojS1q8v2PXFbv3hFPCWEgv+Z8J+xOQHJXDaM+48Bd8g67QkKADxQtFkJHak= v3nco@v3nco.dev"
      # Sentinel SSH
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHFDwAnZIKGTxA8g0o0sQ54WP9ZCLeACy8OHrLG8OADNAAAABHNzaDo="
      # Guardian GPG
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3PiNEseKdDtTl84l6I5j7Mp5zrbRAOvJtIOHfQ1eBXQ+UP4+JD9BkxedRoAO4MFt9aHGUcy1zGEf6mouStjTcMLstpIFGG6pnMMJsFqXg+2tMBePNVGloefVkPjcCekVauTZV51Rr/rQhMLaQZzjf+CicT+/P2xPbE+6RLKwmgFxc0ChAJF4giRiDkF87zGxmuQE219IbCfBTO2dl94RvMXKGUufAJWKu+vi63fXxCVje3WBj/KtntL91aZqE4pgyuis4l9kLzL5hyKeDcM4EvEyimkX4MHDO7YwJlchCRcs1wo18i6/waC3QKYKL7Kgt+BY9Th81qJ5iAwuappotp4ssEo0N8+GxebbMYP6qi7CcsleFcGQSlzmVw2q5K64uCJ+hvI1EE0jPBXCQlJAc5NQtvsR6+FYBWZ/F87i+7y8nn3dWw1KOwXKlKiPlNI5Fn6a5NtQ20tSgyiMQFRQ30ZOwsUFvgoMKTjtsQMEaqljqo0b7L0AOsTyfAXPtY2UQtTxQYzZ7G5wxJIu6eIe8Slisa1T4XHoQGaoF9MWK/v97kYnud9Cp+jhdmlckV7fwyTb2JLF8W4IDsRA7qEgb1p/ERuRarhIkXtjb1FiXF6I+tOKhEPdzy3X9zoiP+SXuE9NzchWHZ59Mr08ZRXaV0s9XkKFRU8y7VwaOc+RSSQ== openpgp:0x148001EA"
    ];
  };
}
