{ lib, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  options.ms0503.gui.enable = mkEnableOption "a gui";
}
