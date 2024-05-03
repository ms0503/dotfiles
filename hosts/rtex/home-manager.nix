{lib, pkgs, ...}: {
  home.packages = with pkgs; [
    rust-bin.nightly.latest.default
  ];
  imports = [
    ../../home-manager/cli
    ../../home-manager/gui
    ../../home-manager/desktop/gnome
  ];
  programs.bash.profileExtra = builtins.readFile ./.profile;
}
