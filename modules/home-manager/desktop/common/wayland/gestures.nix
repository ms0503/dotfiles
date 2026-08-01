{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.wayland;
in
{
  config = mkIf cfg.enable {
    home.file."${config.xdg.configHome}/libinput-gestures.conf".text = ''
      gesture swipe up 3 wofi --show drun --width 512px
    '';
  };
}
