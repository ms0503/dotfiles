{ pkgs, ... }:
{
  home.packages = with pkgs; [
    evince
    spotify
    totem
  ];
  programs = {
    ncspot.enable = true;
    obs-studio.enable = true;
  };
  services.easyeffects.enable = true;
}
# vim: et sts=2 sw=2 ts=2
