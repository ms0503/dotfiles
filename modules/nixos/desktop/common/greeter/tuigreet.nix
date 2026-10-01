{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  inherit (lib) getExe mkIf;
  cfg = config.ms0503.desktop.common;
  cfgGui = config.ms0503.gui;
  cfgInternal = config.ms0503._internal.desktop.common.greeter;
in
{
  config = mkIf (cfgGui.enable && cfg.greeter == "tuigreet") {
    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${getExe pkgs.tuigreet} --remember --remember-session --sessions ${config.system.path}/share/wayland-sessions:${config.system.path}/share/xsessions:${cfgInternal.shell-session}/share/sessions --time --time-format '%Y-%m-%d %H:%M:%S'";
        user = username;
      };
    };
  };
}
