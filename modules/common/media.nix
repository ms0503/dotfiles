{ lib, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  options.ms0503.media.enable = mkEnableOption "media applications";
}
