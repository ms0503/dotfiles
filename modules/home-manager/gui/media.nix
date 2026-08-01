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
  cfgWl = config.ms0503.desktop.common.wayland;
in
{
  config = mkIf cfg.enable {
    home.packages = builtins.concatLists [
      (with pkgs; [
        evince
        rosegarden
        totem
        vlc
        vmpk
      ])
      (
        if cfgWl.enable then
          with myPkgs;
          [
            spotify-wayland
          ]
        else
          with pkgs;
          [
            spotify
          ]
      )
    ];
    programs.ncspot.enable = true;
    services.easyeffects.enable = true;
  };
}
