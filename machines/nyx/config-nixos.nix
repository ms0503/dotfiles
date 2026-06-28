{ myLib, ... }:
{
  ms0503 = {
    arch = "x86_64";
    bluetooth.enable = true;
    bootloader = {
      efi.enable = true;
      type = "lanzaboote";
    };
    desktop.hyprland.enable = true;
    feature-set = myLib.const.feature-sets.full;
    gpu = "nvidia";
    gui.enable = true;
    im = {
      enable = true;
      type = "mozkey";
    };
    media.enable = true;
    rust.extraTools = [ ];
    server = {
      minecraft.enable = false;
      nix-repo-updater.enable = false;
    };
    shell.type = "zsh";
    steam.enable = true;
    wayland.enable = true;
  };
}
