{ myLib, ... }:
{
  ms0503 = {
    arch = "x86_64";
    bluetooth.enable = false;
    desktop.hyprland.enable = false;
    feature-set = myLib.const.feature-sets.lite;
    gpu = "nvidia";
    gui.enable = true;
    media.enable = false;
    rust.extraTools = [ ];
    secureboot.enable = false;
    shell.type = "zsh";
    steam.enable = false;
    wayland.enable = true;
    wsl.enable = true;
  };
}
