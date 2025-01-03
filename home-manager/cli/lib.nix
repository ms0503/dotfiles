{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gtk3
    gtk4
    libglvnd
    openssl
  ];
}
