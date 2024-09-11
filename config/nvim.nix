{config, ...}: {
  home.file."${config.xdg.configHome}/nvim" = {
    recursive = true;
    source = ./nvim;
  };
}
/* vim: set sts=2 sw=2 ts=2 : */
