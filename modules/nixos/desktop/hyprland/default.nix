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
  cfgWl = config.ms0503.desktop.common.wayland;
  hlPkgs = inputs'.hyprland.packages;
in
{
  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfgGui.enable;
        message = "ms0503.gui.enable must be true";
      }
      {
        assertion = cfgWl.enable;
        message = "ms0503.wayland.enable must be true";
      }
    ];
    programs.hyprland = {
      enable = true;
      package = hlPkgs.hyprland;
      portalPackage = hlPkgs.xdg-desktop-portal-hyprland;
      withUWSM = true;
      xwayland.enable = true;
    };
    services.xremap.withHypr = true;
  };
}
