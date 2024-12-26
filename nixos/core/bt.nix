{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.ms0503.bluetooth.enable {
  environment.systemPackages = with pkgs; [
    bluez
    bluez-alsa
    bluez-tools
  ];
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
}
# vim: et sts=2 sw=2 ts=2
