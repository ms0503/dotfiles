{pkgs, ...}: {
  environment.sessionVariables = {
    QT_IM_MODULE = "fcitx";
    SDL_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };
  gtk = {
    gtk2.extraConfig.Settings = ''
      gtk-im-module="fcitx"
    '';
    gtk3.extraConfig.Settings = ''
      gtk-im-module=fcitx
    '';
    gtk4.extraConfig.Settings = ''
      gtk-im-module=fcitx
    '';
  };
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-gtk
        fcitx5-mozc
        fcitx5-skk
      ];
      waylandFrontend = true;
    };
  };
}
