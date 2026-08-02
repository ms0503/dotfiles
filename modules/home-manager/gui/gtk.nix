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
    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
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
      gtk4 = {
        inherit (config.gtk) theme;
        extraConfig.gtk-application-prefer-dark-theme = true;
      };
      iconTheme = {
        name = "Yaru-remix-dark";
        package = pkgs.yaru-remix-theme;
      };
      theme = {
        name = "Yaru-remix-dark";
        package = pkgs.yaru-remix-theme;
      };
    };
  };
}
