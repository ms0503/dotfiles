{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkOption types;
  cfg = config.ms0503.desktop.common;
  cfgGui = config.ms0503.gui;
in
{
  config = mkIf cfgGui.enable {
    assertions = [
      {
        assertion = cfg.greeter != null;
        message = "ms0503.desktop.common.greeter must be set";
      }
    ];
    security.pam.services.greetd.enableGnomeKeyring = true;
  };
  imports = [
    ./tuigreet.nix
  ];
  options.ms0503 = {
    _internal.desktop.common.greeter.shell-session = mkOption {
      default = pkgs.writeTextFile {
        destination = "/share/sessions/shell.desktop";
        name = "shell.desktop";
        text = ''
          [Desktop Entry]
          DesktopNames=${config.ms0503.shell.type}
          Exec=${pkgs.${config.ms0503.shell.type} |> lib.getExe}
          Name=${config.ms0503.shell.type}
          Type=Application
        '';
      };
      readOnly = true;
      type = types.package;
    };
    desktop.common.greeter = mkOption {
      default = null;
      description = "Greeter";
      type =
        types.nullOr
        <| types.enum [
          "tuigreet"
        ];
    };
  };
}
