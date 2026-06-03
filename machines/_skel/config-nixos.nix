{ myLib, ... }:
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
    gpu = null;
    gui.enable = false;
    im.enable = false;
    media.enable = false;
    rust.extraTools = [ ];
    server.minecraft.enable = false;
    shell.type = "zsh";
    steam.enable = false;
    wayland.enable = false;
  };
}
