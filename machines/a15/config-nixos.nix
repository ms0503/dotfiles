{ pkgs, ... }:
{
  ms0503 = {
    bluetooth.enable = true;
    desktop.hyprland.enable = true;
    gpu = "nvidia";
    gui.enable = true;
    media.enable = true;
    rust.extraTools = with pkgs.fenix; [
      targets.thumbv7em-none-eabihf.latest.rust-std
      targets.thumbv7em-none-eabihf.stable.rust-std
    ];
    secureboot.enable = true;
    steam.enable = true;
    wayland.enable = true;
  };
}
