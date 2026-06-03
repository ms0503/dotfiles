{ config, lib, ... }:
let
  inherit (lib) mkIf mkOption types;
  cfg = config.ms0503.terminal;
  cfgGui = config.ms0503.gui;
in
{
  config = mkIf cfgGui.enable {
    assertions = [
      {
        assertion = cfg != null;
        message = "ms0503.terminal must not be null when gui is enabled";
      }
    ];
  };
  options.ms0503.terminal = mkOption {
    description = "Choose a terminal emulator";
    type = types.nullOr (
      types.enum [
        "ghostty"
        "wezterm"
      ]
    );
  };
}
