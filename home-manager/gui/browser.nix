{ pkgs, ... }:
{
  home.packages = with pkgs; [
    firefox-devedition
  ];
}
# vim: et sts=2 sw=2 ts=2
