{pkgs, ...}: {
  home.packages = with pkgs.gnomeExtensions; [
    appindicator
    dash-to-dock
    hibernate-status-button
    kimpanel
    tiling-assistant
  ];
}
