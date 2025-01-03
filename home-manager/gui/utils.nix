{ config, pkgs, ... }:
let
  discord-canary-wayland = pkgs.discord-canary.overrideAttrs (
    _: _: {
      preInstall = ''
        gappsWrapperArgs+=(
          --add-flags "--enable-wayland-ime"
          --add-flags "--disable-gpu-compositing"
        )
      '';
    }
  );
in
{
  home.packages = with pkgs; [
    (if config.ms0503.wayland.enable then discord-canary-wayland else discord-canary)
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
