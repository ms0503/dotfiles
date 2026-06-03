{ lib, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  options.ms0503.wayland.enable = mkEnableOption "a wayland";
}
