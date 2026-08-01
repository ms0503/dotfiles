{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.desktop.common.wayland;
  cfgGui = config.ms0503.gui;
in
{
  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfgGui.enable;
        message = "ms0503.gui.enable must be true";
      }
    ];
    home = {
      packages = with pkgs; [
        awww
        wev
        wf-recorder
        wl-clipboard
        wlogout
      ];
      sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
    xdg.configFile."uwsm/env".source =
      "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  };
  imports = [
    ./dunst.nix
    ./gestures.nix
    ./swaylock.nix
    ./waybar.nix
    ./wofi.nix
  ];
}
