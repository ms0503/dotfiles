{ pkgs, ... }:
{
  home.packages = with pkgs; [
    evince
    rosegarden
    spotify
    totem
    vlc
    vmpk
  ];
  programs = {
    ncspot.enable = true;
    obs-studio.enable = true;
  };
  services.easyeffects.enable = true;
}
