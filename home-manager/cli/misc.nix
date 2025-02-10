{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cava
    fastfetch
    sl
  ];
}
