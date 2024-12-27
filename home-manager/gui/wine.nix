{ pkgs, ... }:
{
  home.packages = with pkgs; [
    winePackages.stagingFull
    winetricks
  ];
}
# vim: et sts=2 sw=2 ts=2
