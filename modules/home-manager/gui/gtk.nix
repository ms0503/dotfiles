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
    gtk = {
      enable = true;
      font = {
        name = "Noto Sans CJK JP";
        package = myPkgs.noto-fonts-cjk-sans-non-variable;
        size = 10;
      };
      gtk2.extraConfig = ''
        gtk-application-prefer-dark-theme=true
      '';
      gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
      iconTheme = {
        name = "Yaru-dark";
        package = pkgs.yaru-theme;
      };
      theme = {
        name = "Yaru-dark";
        package = pkgs.yaru-theme;
      };
    };
  };
}
