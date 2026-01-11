{ lib, myLib, ... }:
let
  inherit (lib)
    attrValues
    last
    mkEnableOption
    mkOption
    sort
    ;
  inherit (myLib) const;
  types = lib.types // myLib.types;
in
{
  options.ms0503 = {
    desktop = {
      hyprland.enable = mkEnableOption "Hyprland";
    };
    feature-set =
      let
        feature-set-max = last feature-set-values;
        feature-set-min = builtins.elemAt feature-set-values 0;
        feature-set-values = sort (a: b: a < b) (attrValues const.feature-sets);
      in
      mkOption {
        description = "Feature Set.";
        type = types.ints.between feature-set-min feature-set-max;
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
    steam.enable = mkEnableOption "a steam";
    wayland.enable = mkEnableOption "a wayland";
  };
}
