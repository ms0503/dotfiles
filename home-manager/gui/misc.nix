{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gimp
    libreoffice-fresh
    minecraft
  ];
}
