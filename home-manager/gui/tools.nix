{pkgs, ...}: {
  home.packages = with pkgs; [
    aseprite
    gnome.dconf-editor
    gnome.file-roller
    gnome.gnome-terminal
    gnome.nautilus
    jetbrains-toolbox
    remmina
    slack
    vscode
    zoom-us
  ];
}
