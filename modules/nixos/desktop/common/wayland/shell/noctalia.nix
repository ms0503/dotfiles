{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.desktop.common.wayland;
in
{
  config = mkIf (cfg.enable && cfg.shell == "noctalia") {
    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
      systemd.enable = true;
    };
  };
}
