{ config, ... }:
{
  home.file = {
    "${config.home.homeDirectory}/.bash_aliases".source = ./bash/.bash_aliases;
    "${config.home.homeDirectory}/.bash_logout".source = ./bash/.bash_logout;
    "${config.home.homeDirectory}/.bash_profile".source = ./bash/.bash_profile;
    "${config.home.homeDirectory}/.bashrc".source = ./bash/.bashrc;
    "${config.home.homeDirectory}/.profile".source = ./bash/.profile;
  };
}
# vim: set et sts=2 sw=2 ts=2 :
