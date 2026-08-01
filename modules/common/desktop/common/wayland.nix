{ lib, ... }:
let
  inherit (lib) mkEnableOption mkOption types;
in
{
  options.ms0503.desktop.common.wayland = {
    enable = mkEnableOption "Wayland";
    shell = mkOption {
      default = null;
      description = "Desktop shell.";
      type = types.nullOr (
        types.enum [
          "noctalia"
        ]
      );
    };
  };
}
