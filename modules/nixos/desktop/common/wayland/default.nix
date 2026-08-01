{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.desktop.common.wayland;
  cfgGui = config.ms0503.gui;
in
{
  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfgGui.enable;
        message = "ms0503.gui.enable must be true";
      }
    ];
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    security.pam.services.swaylock = { };
  };
}
