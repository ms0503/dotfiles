{ config, lib, ... }:
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
  options.ms0503.desktop.common.greeter = mkOption {
    default = null;
    description = "Greeter";
    type =
      types.nullOr
      <| types.enum [
        "tuigreet"
      ];
  };
}
