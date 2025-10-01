{
  config,
  pkgs,
  lib,
  ...
}:
let
  videoNr = 10;
  device = "/dev/video${toString videoNr}";
in
{
  # Virtual webcam via v4l2loopback
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=${toString videoNr} exclusive_caps=1 card_label="MacCam"
  '';

  # Make the device readable by any user (avoids group tweaks)
  services.udev.extraRules = ''
    KERNEL=="video${toString videoNr}", MODE="0666"
  '';

  # Tools
  environment.systemPackages = with pkgs; [
    ffmpeg-full
    v4l-utils
  ];

  # Open inbound ports (SRT 9999; optional UDP 23000)
  networking.firewall.allowedUDPPorts = [
    9999
    23000
  ];

  # Always-on SRT receiver → virtual webcam
  systemd.services.maccam-video = {
    description = "Receive Mac camera over SRT and feed v4l2loopback";
    after = [
      "network-online.target"
      "systemd-modules-load.service"
    ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.ffmpeg-full}/bin/ffmpeg -loglevel warning -fflags nobuffer -flags low_delay -i srt://0.0.0.0:9999?mode=listener -f v4l2 -pix_fmt yuv420p ${device}";
      Restart = "always";
      RestartSec = 2;
    };
    wantedBy = [ "multi-user.target" ];
  };
}
