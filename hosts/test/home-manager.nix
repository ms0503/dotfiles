{pkgs, ...}: {
  home.packages = with pkgs; [
    rust-bin.nightly.latest.default
  ];
  imports = [
    ../../home-manager/cli
    ../../home-manager/gui
    ../../home-manager/gui/unityhub.nix
    ../../home-manager/desktop/gnome
  ];
}
