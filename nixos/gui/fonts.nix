{ myPkgs, pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    fontconfig.defaultFonts = {
      emoji = [
        "Noto Color Emoji"
      ];
      monospace = [
        "SauceCodePro Nerd Font"
        "Source Han Code JP"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Noto Sans CJK JP"
        "Noto Color Emoji"
      ];
      serif = [
        "Noto Serif CJK JP"
        "Noto Color Emoji"
      ];
    };
    packages =
      (with pkgs; [
        nerd-fonts.sauce-code-pro
        noto-fonts-emoji
        source-han-code-jp
      ])
      ++ (with myPkgs; [
        noto-fonts-cjk-sans-non-variable
        noto-fonts-cjk-serif-non-variable
        noto-fonts-non-variable
      ]);
  };
}
