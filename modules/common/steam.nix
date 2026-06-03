{ lib, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  options.ms0503.steam.enable = mkEnableOption "a steam";
}
