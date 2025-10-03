{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfgGUI = config.ms0503.gui;
  cfgHyprland = config.ms0503.desktop.hyprland;
in
{
  config = mkIf (cfgGUI.enable && cfgHyprland.enable) {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          background = "#222222";
          corner_radius = 10;
          font = "Noto Sans CJK JP";
          foreground = "#dddddd";
          frame_color = "#222222";
          monitor = 1;
          offset = "30x30";
          timeout = 10;
          transparency = 10;
        };
        urgency_critical.frame_color = "#ff4444";
      };
    };
  };
}
