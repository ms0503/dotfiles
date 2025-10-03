{
  config,
  lib,
  myPkgs,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfgGUI = config.ms0503.gui;
  godotPackages = pkgs.godotPackages_4_4;
in
{
  config = mkIf cfgGUI.enable {
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
          (blender.override {
            cudaSupport = config.ms0503.gpu == "nvidia";
            hipSupport = config.ms0503.gpu == "radeon";
          })
          (gimp3-with-plugins.override {
            gimpPlugins = gimp3Plugins.override {
              gimp = gimp3.overrideAttrs (
                let
                  python = python3.withPackages (
                    pp: with pp; [
                      pygobject3
                    ]
                  );
                in
                _: prev: {
                  preFixup = prev.preFixup + ''
                    gappsWrapperArgs+=(
                      --prefix PATH : ${
                        lib.makeBinPath [
                          python
                        ]
                      }
                    )
                  '';
                }
              );
            };
          })
          aseprite-unfree
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
  };
}
