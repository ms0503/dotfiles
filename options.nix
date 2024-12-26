{ lib, ... }:
let
  desktops = lib.types.enum [
    "hyprland"
  ];
in
{
  options.ms0503 = {
    bluetooth.enable = lib.mkEnableOption "a bluetooth support";
    desktop = lib.mkOption {
      type = desktops;
    };
    gui.enable = lib.mkEnableOption "a gui";
    media.enable = lib.mkEnableOption "media applications";
    secureboot.enable = lib.mkEnableOption "a secureboot";
    steam.enable = lib.mkEnableOption "a steam";
    wayland.enable = lib.mkEnableOption "a wayland";
  };
}
# vim: et sts=2 sw=2 ts=2
