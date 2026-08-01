{ config, lib, ... }:
let
  inherit (lib) mkIf mkOption types;
  cfg = config.ms0503;
  cfgGui = config.ms0503.gui;
in
{
  config = mkIf cfgGui.enable {
    assertions = [
      {
        assertion = cfg.terminal != null;
        message = "ms0503.terminal must not be null when gui is enabled";
      }
    ];
  };
  options.ms0503 = {
    terminal = mkOption {
      description = "Choose a terminal emulator";
      type = types.nullOr (
        types.enum [
          "ghostty"
          "wezterm"
        ]
      );
    };
    terminalCmd = mkOption {
      default =
        if cfg.terminal == "ghostty" then
          "ghostty"
        else if cfg.terminal == "wezterm" then
          "wezterm"
        else
          throw "unreachable code";
      description = "Command of terminal emulator";
      readOnly = true;
      type = types.str;
    };
    terminalCmdWith = mkOption {
      default =
        if cfg.terminal == "ghostty" then
          "${cfg.terminalCmd} -e"
        else if cfg.terminal == "wezterm" then
          "${cfg.terminalCmd} start"
        else
          throw "unreachable code";
      description = "Command of terminal emulator, which run the specified command";
      readOnly = true;
      type = types.str;
    };
    terminalSsh = mkOption {
      default =
        if cfg.terminal == "ghostty" then
          "${cfg.terminalCmdWith} ssh"
        else if cfg.terminal == "wezterm" then
          "${cfg.terminalCmd} ssh"
        else
          throw "unreachable code";
      description = "SSH command of terminal emulator";
      readOnly = true;
      type = types.str;
    };
  };
}
