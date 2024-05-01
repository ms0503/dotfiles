{lib, pkgs, ...}: {
  imports = [
    ../../home-manager/cli
    ../../home-manager/gui
    ../../home-manager/desktop/gnome
  ];
  programs.bash.profileExtra = builtins.readFile ./.profile;
}
