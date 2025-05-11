{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.gpu;
in
{
  config = mkIf (cfg == "radeon") { };
}
