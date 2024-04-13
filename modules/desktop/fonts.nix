{inputs, pkgs, ...}: let
  myPackages = inputs.self.outputs.packages.${pkgs.system};
in {
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
    packages = (with pkgs; [
      (nerdfonts.override {
        fonts = [
          "SourceCodePro"
        ];
      })
      noto-fonts-emoji
      source-han-code-jp
    ]) ++ (with myPackages; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ]);
  };
}
