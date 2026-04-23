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
    gpu = "nvidia";
    gui.enable = false;
    media.enable = false;
    rust.extraTools = [ ];
    shell.type = "zsh";
    steam.enable = false;
    wayland.enable = false;
  };
}
