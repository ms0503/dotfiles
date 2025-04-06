{
  config,
  myPkgs,
  pkgs,
  ...
}:
{
  home = {
    file."${config.xdg.dataHome}/godot/export_templates/${
      builtins.replaceStrings [ "-" ] [ "." ] pkgs.godot-mono.version
    }.mono" =
      {
        recursive = true;
        source = pkgs.godot-export-templates;
      };
    packages =
      (with pkgs; [
        aseprite-unfree
        gimp
        godot-mono
        kicad
        libreoffice-fresh
        networkmanagerapplet
        thunderbird-latest
        winePackages.stagingFull
        winetricks
        xdg-utils
        zoom-us
      ])
      ++ (with myPkgs; [
        blender3
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
  };
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
