{ lib, ... }:
let
  inherit (lib) mkEnableOption mkOption;
  desktops = lib.types.enum [
    "hyprland"
  ];
  gpus = lib.types.enum [
    "none"
    "nvidia"
    "radeon"
  ];
in
{
  options.ms0503 = {
    bluetooth.enable = mkEnableOption "a bluetooth support";
    desktop = mkOption {
      description = "Desktop environment.";
      type = desktops;
    };
    gpu = mkOption {
      description = "GPU family.";
      type = gpus;
    };
    gui.enable = mkEnableOption "a gui";
    media.enable = mkEnableOption "media applications";
    secureboot.enable = mkEnableOption "a secureboot";
    steam.enable = mkEnableOption "a steam";
    unity.enable = mkEnableOption "Unity and some applications";
    wayland.enable = mkEnableOption "a wayland";
  };
}
