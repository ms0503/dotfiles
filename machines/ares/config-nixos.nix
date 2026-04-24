{ myLib, ... }:
{
  ms0503 = {
    arch = "x86_64";
    bluetooth.enable = false;
    bootloader = {
      efi.enable = false;
      type = "grub";
    };
    desktop.hyprland.enable = false;
    feature-set = myLib.const.feature-sets.tiny;
    gpu = "none";
    gui.enable = false;
    media.enable = false;
    rust.extraTools = [ ];
    server.minecraft.enable = false;
    shell.type = "zsh";
    steam.enable = false;
    wayland.enable = false;
  };
}
