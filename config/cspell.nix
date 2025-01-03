{ config, ... }:
{
  home.file."${config.xdg.configHome}/cspell" = {
    recursive = true;
    source = ./cspell;
  };
}
