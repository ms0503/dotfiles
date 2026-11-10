{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.gui;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = [
      config.services.pipewire.package.jack
    ];
    security.rtkit.enable = true;
    services = {
      pipewire = {
        alsa = {
          enable = true;
          support32Bit = true;
        };
        enable = true;
        pulse.enable = true;
      };
      pulseaudio.enable = false;
    };
  };
}
