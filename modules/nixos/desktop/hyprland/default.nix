{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.desktop.hyprland;
  cfgGui = config.ms0503.gui;
  cfgWl = config.ms0503.desktop.common.wayland;
  hlPkgs = import inputs.nixpkgs {
    inherit (pkgs) config;
    inherit (pkgs.stdenv.hostPlatform) system;
    overlays = [
      inputs.hyprland.overlays.hyprland-packages
      inputs.hyprland.overlays.hyprland-extras
      (final: prev: {
        aquamarine = prev.aquamarine.overrideAttrs (
          _: prev': {
            patches =
              (prev'.patches or [ ])
              ++ lib.optional (config.ms0503.gpu == "nvidia") ./hotfix-aquamarine-blocking-modeset-pageflip.patch;
          }
        );
        hyprland-guiutils = prev.hyprland-guiutils.overrideAttrs (
          _: prev': {
            buildInputs = (prev'.buildInputs or [ ]) ++ [
              final.libdrm
            ];
          }
        );
        hyprtoolkit = prev.hyprtoolkit.overrideAttrs (
          _: prev': {
            buildInputs = (prev'.buildInputs or [ ]) ++ [
              final.wayland
            ];
          }
        );
        xdg-desktop-portal-hyprland = prev.xdg-desktop-portal-hyprland.overrideAttrs (
          _: prev': {
            buildInputs = (prev'.buildInputs or [ ]) ++ [
              final.wayland
            ];
          }
        );
      })
    ];
  };
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
