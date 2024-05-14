{lib, pkgs, ...}: {
  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "SourceCodePro"
      ];
    })
  ];
  imports = [
    ../../home-manager/cli
    ../../home-manager/gui
    ../../home-manager/desktop/gnome
  ];
  programs.bash.profileExtra = (builtins.readFile ../../home-manager/cli/bash/.profile) + (builtins.readFile ./.profile);
}
