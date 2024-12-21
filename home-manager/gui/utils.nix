{ pkgs, ... }:
{
  home.packages = with pkgs; [
    discord-canary
    slack
    zoom-us
  ];
  programs.urxvt = {
    enable = true;
    fonts = [
      "xft:SauceCodePro Nerd Font:size=10"
      "xft:Source Han Code JP:size=10"
    ];
    shading = 75;
    transparent = true;
  };
}
# vim: et sts=2 sw=2 ts=2
