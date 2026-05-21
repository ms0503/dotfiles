{
  config,
  inputs',
  lib,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.desktop.hyprland;
  cfgGui = config.ms0503.gui;
  hlPkgs = inputs'.hyprland.packages;
in
{
  config = mkIf (cfgGui.enable && cfg.enable) {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    programs.hyprland = {
      enable = true;
      package = hlPkgs.hyprland;
      portalPackage = hlPkgs.xdg-desktop-portal-hyprland;
      withUWSM = true;
      xwayland.enable = true;
    };
    security.pam.services.swaylock = { };
    services.xremap.withHypr = true;
  };
}
