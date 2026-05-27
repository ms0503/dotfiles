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
      hazkey.enableGpu = true;
      type = "hazkey";
    };
    media.enable = true;
    rust.extraTools = [ ];
    server.minecraft.enable = false;
    shell.type = "zsh";
    steam.enable = true;
    wayland.enable = true;
  };
}
