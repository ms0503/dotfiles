{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.desktop.common.wayland;
in
{
  config = mkIf (cfg.enable && cfg.shell == null) {
    security.pam.services.swaylock = { };
  };
}
