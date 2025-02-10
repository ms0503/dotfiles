{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.ms0503.bluetooth;
in
{
  config = mkIf cfg.enable {
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
  };
  options.ms0503.bluetooth.enable = mkEnableOption "a bluetooth support";
}
