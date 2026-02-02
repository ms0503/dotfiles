{ myLib, ... }:
{
  ms0503 = {
    arch = "x86_64";
    bluetooth.enable = false;
    desktop.hyprland.enable = false;
    feature-set = myLib.const.feature-sets.tiny;
    gpu = "nvidia";
    gui.enable = false;
    media.enable = false;
    rust.extraTools = [ ];
    secureboot.enable = true;
    shell.type = "zsh";
    steam.enable = false;
    wayland.enable = false;
  };
}
