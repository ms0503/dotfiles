{
  config,
  lib,
  myPkgs,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.gui;
in
{
  config = mkIf cfg.enable {
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
