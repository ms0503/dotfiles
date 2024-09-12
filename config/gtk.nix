{config, ...}: {
  home.file = {
    "${config.xdg.configHome}/gtk-2.0/gtkrc".source = ./gtk/gtkrc;
    "${config.xdg.configHome}/gtk-3.0/settings.ini".source = ./gtk/settings3.ini;
    "${config.xdg.configHome}/gtk-4.0/settings.ini".source = ./gtk/settings4.ini;
  };
}
/* vim: set sts=2 sw=2 ts=2 : */
