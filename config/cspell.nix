{ config, ... }:
{
  home.file."${config.xdg.configHome}/cspell" = {
    recursive = true;
    source = ./cspell;
  };
}
# vim: et sts=2 sw=2 ts=2
