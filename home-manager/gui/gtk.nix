{ pkgs, ... }:
{
  gtk = {
    enable = true;
    font = {
      name = "Noto Sans CJK JP";
      package = pkgs.noto-fonts-cjk-sans;
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
}
