{
  config,
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
    obs-studio.enable = true;
  };
  services.easyeffects.enable = true;
}
