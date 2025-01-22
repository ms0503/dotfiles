{ pkgs, ... }:
{
  config.ms0503 = {
    bluetooth.enable = true;
    desktop = "hyprland";
    gpu = "nvidia";
    gui.enable = true;
    media.enable = true;
    rust.extraTools = with pkgs.fenix; [
      targets.thumbv7em-none-eabihf.latest.rust-std
      targets.thumbv7em-none-eabihf.stable.rust-std
    ];
    secureboot.enable = true;
    steam.enable = true;
    unity.enable = true;
    wayland.enable = true;
  };
}
