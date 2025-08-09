{ config, pkgs, ...  }:
{
  services.gpg-agent = {
    enable = true;
    enableScDaemon = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };
  programs.gpg = {
    enable = true;
    publicKeys = [{source = "/home/venco/nixos-config/public-keys/6FAA8732F6512AAD6EDC522AE5E0FA4E59297845.asc"; trust = 5;}];
    settings = {
      personal-cipher-preferences = "AES256 AES192 AES";
      personal-digest-preferences = "SHA512 SHA384 SHA256";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
      cert-digest-algo = "SHA512";
      s2k-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";
      charset = "utf-8";
      no-comments = true;
      no-emit-version = true;
      no-greeting = true;
      keyid-format = "0xlong";
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      with-fingerprint = true;
      require-cross-certification = true;
      require-secmem = true;
      no-symkey-cache = true;
      armor = true;
      use-agent = true;
      throw-keyids = true;
      keyserver = ["hkps://keys.openpgp.org" "hkps://keys.mailvelope.com" "hkps://keyserver.ubuntu.com:443" "hkps://pgpkeys.eu" "hkps://pgp.circl.lu"];
    };
    scdaemonSettings = {
      disable-ccid = true;
    };
  };
}