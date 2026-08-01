{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.ms0503.desktop.common.wayland.shell = mkOption {
    default = null;
    description = "Desktop shell.";
    type = types.nullOr (
      types.enum [
      ]
    );
  };
}
