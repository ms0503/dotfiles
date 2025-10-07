{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.gui;
in
{
  config = mkIf cfg.enable {
    programs.dconf.enable = true;
  };
}
