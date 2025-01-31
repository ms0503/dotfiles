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
    bash.aliases = mkOption {
      description = "Bash aliases.";
      type = lib.types.attrsOf lib.types.str;
    };
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
    rust.extraTools = mkOption {
      description = "Extra Rust tools.";
      type = lib.types.listOf lib.types.package;
    };
    secureboot.enable = mkEnableOption "a secureboot";
    steam.enable = mkEnableOption "a steam";
    unity.enable = mkEnableOption "Unity and some applications";
    wayland.enable = mkEnableOption "a wayland";
  };
}
