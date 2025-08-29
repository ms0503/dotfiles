{ pkgs, ... }:
{
  ms0503 = {
    desktop.hyprland.enable = true;
    gpu = "nvidia";
    gui.enable = true;
    jetbrains.enable = true;
    media.enable = true;
    rust.extraTools = with pkgs.fenix; [
      targets.thumbv7em-none-eabihf.latest.rust-std
      targets.thumbv7em-none-eabihf.stable.rust-std
    ];
    shell = {
      aliases = { };
      type = "zsh";
    };
    terminal = "wezterm";
    unity.enable = true;
    wayland.enable = true;
  };
}
