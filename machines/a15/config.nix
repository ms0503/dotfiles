{ lib, ... }:
{
  config.ms0503 = {
    bluetooth.enable = true;
    desktop = "hyprland";
    gui.enable = true;
    media.enable = true;
    secureboot.enable = true;
    steam.enable = true;
    unity.enable = true;
    wayland.enable = true;
  };
}
