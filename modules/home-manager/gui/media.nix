{
  config,
  lib,
  myPkgs,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfgGUI = config.ms0503.gui;
in
{
  config = mkIf cfgGUI.enable {
    home.packages =
      with pkgs;
      [
        evince
        rosegarden
        totem
        vlc
        vmpk
      ]
      ++ (
        if config.ms0503.wayland.enable then
          with myPkgs;
          [
            spotify-wayland
          ]
        else
          with pkgs;
          [
            spotify
          ]
      );
    programs.ncspot.enable = true;
    services.easyeffects.enable = true;
  };
}
