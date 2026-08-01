{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.desktop.hyprland;
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings.gesture = [
      {
        action = "workspace";
        direction = "horizontal";
        fingers = 3;
        scale = 0.5;
      }
    ];
  };
}
