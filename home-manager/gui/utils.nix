{ pkgs, ... }:
let
  discord-canary-wayland = pkgs.discord-canary.overrideAttrs (
    _: _: {
      preInstall = ''
        gappsWrapperArgs+=(
          --add-flags "--enable-wayland-ime"
        )
      '';
    }
  );
in
{
  home.packages = with pkgs; [
    discord-canary-wayland
    networkmanagerapplet
    slack
    zoom-us
  ];
  programs.urxvt = {
    enable = true;
    fonts = [
      "xft:SauceCodePro Nerd Font:size=10"
      "xft:Source Han Code JP:size=10"
    ];
    iso14755 = true;
    shading = 75;
    transparent = true;
  };
}
# vim: et sts=2 sw=2 ts=2
