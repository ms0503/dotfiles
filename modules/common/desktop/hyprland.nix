{ lib, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  options.ms0503.desktop.hyprland.enable = mkEnableOption "Hyprland";
}
