{ pkgs, ... }:
{
  gtk = {
    enable = true;
    font = {
      name = "Noto Sans CJK JP";
      package = pkgs.noto-fonts-cjk-sans;
      size = 11;
    };
    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme=true
      gtk-im-module="fcitx"
    '';
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-im-module = "fcitx";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-im-module = "fcitx";
    };
    iconTheme = {
      name = "Yaru-dark";
      package = pkgs.yaru-theme;
    };
    theme = {
      name = "Yaru-dark";
      package = pkgs.yaru-theme;
    };
  };
}
# vim: et sts=2 sw=2 ts=2
