{config, ...}: {
  home.file."${config.home.homeDirectory}/.gitconfig".source = ./git/.gitconfig;
}
/* vim: set sts=2 sw=2 ts=2 : */
