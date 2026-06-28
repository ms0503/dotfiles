{ myLib, pkgs, ... }:
{
  ms0503 = {
    arch = "x86_64";
    bluetooth.enable = false;
    bootloader = {
      efi.enable = true;
      type = "lanzaboote";
    };
    desktop.hyprland.enable = false;
    feature-set = myLib.const.feature-sets.tiny;
    gpu = "nvidia";
    gui.enable = false;
    im.enable = false;
    media.enable = false;
    rust.extraTools = [ ];
    server = {
      minecraft = {
        enable = true;
        servers.create-aeronautics = {
          jre = pkgs.javaPackages.compiler.temurin-bin.jre-21;
          port = 25565;
          query = {
            enable = true;
            port = 25565;
          };
          rcon = {
            enable = true;
            port = 25575;
          };
        };
      };
      nix-repo-updater = {
        enable = true;
        repos = [
          {
            delay = 15 * 60;
            owner = "ms0503";
            repo = "dotfiles";
          }
          {
            owner = "ms0503";
            repo = "neovim-custom";
          }
          {
            owner = "ms0503";
            repo = "pkgs.nix";
          }
        ];
      };
    };
    shell.type = "zsh";
    steam.enable = false;
    wayland.enable = false;
  };
}
