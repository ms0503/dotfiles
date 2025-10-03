{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfgGUI = config.ms0503.gui;
in
{
  config = mkIf cfgGUI.enable {
    home.packages = with pkgs; [
      (prismlauncher.overrideAttrs (
        _: prev: {
          qtWrapperArgs = prev.qtWrapperArgs ++ [
            "--unset WAYLAND_DISPLAY"
          ];
        }
      ))
    ];
  };
}
