{config, ...}: {
  home.file."${config.xdg.configHome}/starship.toml".source = ./starship/starship.toml;
}
/* vim: set sts=2 sw=2 ts=2 : */
