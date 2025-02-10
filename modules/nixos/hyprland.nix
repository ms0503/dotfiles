{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfgGUI = config.ms0503.gui;
  cfgHyprland = config.ms0503.desktop.hyprland;
in
{
  config = mkIf cfgGUI.enable (
    mkIf cfgHyprland.enable {
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };
      security.pam.services.swaylock = { };
      services.xremap.withHypr = true;
    }
  );
}
