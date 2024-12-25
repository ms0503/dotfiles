{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gtk3
    gtk4
    libglvnd
    openssl
  ];
}
# vim: et sts=2 sw=2 ts=2
