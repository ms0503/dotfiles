{pkgs, ...}: {
  home.packages = [
  ];
  imports = [
    ../../home-manager/cli
    ../../home-manager/gui
    ../../home-manager/desktop/gnome
  ];
  programs.bash = {
    bashrcExtra = builtins.readFile ./.bashrc;
    profileExtra = (builtins.readFile ../../home-manager/cli/bash/.profile) + (builtins.readFile ./.profile);
  };
}
