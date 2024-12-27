{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wineWowPackages.stagingFull
    winetricks
  ];
}
# vim: et sts=2 sw=2 ts=2
