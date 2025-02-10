{
  config,
  myPkgs,
  pkgs,
  ...
}:
{
  home.packages =
    (with pkgs; [
      gimp
      libreoffice-fresh
      networkmanagerapplet
      thunderbird-latest
      winePackages.stagingFull
      winetricks
      xdg-utils
      zoom-us
    ])
    ++ (
      if config.ms0503.wayland.enable then
        with myPkgs;
        [
          discord-canary-wayland
          slack-wayland
        ]
      else
        with pkgs;
        [
          discord-canary
          slack
        ]
    );
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
  xdg.enable = true;
}
