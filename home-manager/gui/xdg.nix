{ pkgs, ... }:
{
  home.packages = with pkgs; [
    xdg-utils
  ];
  xdg.enable = true;
}
# vim: et sts=2 sw=2 ts=2
