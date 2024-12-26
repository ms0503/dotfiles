{ lib, ... }:
{
  config.ms0503 = {
    bluetooth.enable = true;
    desktop = "hyprland";
    gui.enable = true;
    media.enable = true;
    secureboot.enable = true;
    steam.enable = true;
    wayland.enable = true;
  };
}
# vim: et sts=2 sw=2 ts=2