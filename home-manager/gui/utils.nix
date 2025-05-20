{
  config,
  inputs',
  lib,
  myPkgs,
  pkgs,
  ...
}:
let
  godotPackages = pkgs.godotPackages_4_4;
in
{
  home = {
    file."${config.xdg.dataHome}/godot/export_templates/${
      builtins.replaceStrings [ "-" ] [ "." ] godotPackages.godot-mono.version
    }.mono" =
      {
        recursive = true;
        source = godotPackages.export-templates-bin;
      };
    packages =
      (with pkgs; [
        aseprite-unfree
        gimp
        kicad
        libreoffice-fresh
        networkmanagerapplet
        realvnc-vnc-viewer
        thunderbird-latest
        wineWowPackages.stagingFull
        winetricks
        xdg-utils
        zoom-us
      ])
      ++ (with godotPackages; [
        godot-mono
      ])
      ++ lib.optional (pkgs.system == "x86_64-linux") inputs'.nix-warez-blender.packages.blender_3_6
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
