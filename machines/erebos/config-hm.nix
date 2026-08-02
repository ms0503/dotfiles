{ myLib, pkgs, ... }:
{
  ms0503 = {
    desktop = {
      common.wayland = {
        enable = true;
        noctalia.monitors.eDP-1 = {
          height = 1080;
          width = 1920;
        };
        shell = "noctalia";
      };
      hyprland = {
        enable = true;
        startup-monitor = 0;
      };
    };
    feature-set = myLib.const.feature-sets.full;
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
    steam.enable = true;
    terminal = "wezterm";
    unity.enable = true;
  };
}
