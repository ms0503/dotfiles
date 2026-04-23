{ myLib, pkgs, ... }:
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
    media.enable = true;
    rust.extraTools = with pkgs.fenix; [
      targets.thumbv7em-none-eabihf.latest.rust-std
      targets.thumbv7em-none-eabihf.stable.rust-std
    ];
    shell.type = "zsh";
    steam.enable = true;
    wayland.enable = true;
  };
}
