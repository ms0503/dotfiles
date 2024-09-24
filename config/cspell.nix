{config, ...}: {
  home.file."${config.xdg.configHome}/cspell" = {
    recursive = true;
    source = ./cspell;
  };
}
/* vim: set sts=2 sw=2 ts=2 : */
