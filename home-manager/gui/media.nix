{
  config,
  lib,
  myPkgs,
  pkgs,
  ...
}:
{
  home.packages =
    with pkgs;
    [
      evince
      rosegarden
      totem
      vlc
      vmpk
    ]
    ++ (
      if config.ms0503.wayland.enable then
        with myPkgs;
        [
          spotify-wayland
        ]
      else
        with pkgs;
        [
          spotify
        ]
    );
  programs = {
    ncspot.enable = true;
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-gstreamer
        obs-pipewire-audio-capture
        obs-vaapi
        obs-vkcapture
        wlrobs
      ];
    };
  };
  services.easyeffects.enable = true;
}
