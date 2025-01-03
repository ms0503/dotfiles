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
