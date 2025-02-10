{ config, pkgs, ... }:
let
  spotify-wayland = pkgs.spotify.overrideAttrs (
    _: _: {
      preFixup = ''
        gappsWrapperArgs+=(
          --add-flags "--enable-wayland-ime"
          --add-flags "--disable-gpu-compositing"
        )
      '';
    }
  );
in
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
    obs-studio.enable = true;
  };
  services.easyeffects.enable = true;
}
