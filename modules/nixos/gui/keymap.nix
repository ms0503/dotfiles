{
  config,
  lib,
  username,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.gui;
in
{
  config = mkIf cfg.enable {
    hardware.uinput.enable = true;
    services.xremap = {
      config = {
        keymap = [ ];
        modmap = [ ];
      };
      enable = true;
      serviceMode = "user";
      userName = username;
    };
    users.groups = {
      input.members = [
        username
      ];
      uinput.members = [
        username
      ];
    };
  };
}
