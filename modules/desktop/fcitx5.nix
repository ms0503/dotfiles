{pkgs, ...}: {
  environment.sessionVariables = {
    QT_IM_MODULE = "fcitx";
    SDL_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
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
