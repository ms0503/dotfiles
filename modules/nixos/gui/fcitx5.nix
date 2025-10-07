{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.gui;
  cfgWayland = config.ms0503.wayland;
in
{
  config = mkIf cfg.enable {
    i18n.inputMethod = {
      enable = true;
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-mozc-ut
        ];
        waylandFrontend = cfgWayland.enable;
      };
      type = "fcitx5";
    };
  };
}
