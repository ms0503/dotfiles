{ lib, myLib, ... }:
let
  inherit (lib) mkEnableOption mkOption;
  types = lib.types // myLib.types;
in
{
  options.ms0503 = {
    desktop = {
      hyprland.enable = mkEnableOption "Hyprland";
    };
    gpu = mkOption {
      description = "GPU family.";
      type = types.gpus;
    };
    gui.enable = mkEnableOption "a gui";
    media.enable = mkEnableOption "media applications";
    rust.extraTools = mkOption {
      description = "Extra Rust tools.";
      type = types.listOf types.package;
    };
    shell.type = mkOption {
      description = "Login shell.";
      type = types.shells;
    };
    wayland.enable = mkEnableOption "a wayland";
  };
}
