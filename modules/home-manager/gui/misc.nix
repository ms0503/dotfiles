{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.gui;
in
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (prismlauncher.overrideAttrs (
        _: prev: {
          qtWrapperArgs = builtins.concatLists [
            prev.qtWrapperArgs
            [
              "--unset WAYLAND_DISPLAY"
            ]
          ];
        }
      ))
    ];
  };
}
