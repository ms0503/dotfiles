{ myLib, ... }:
{
  ms0503 = {
    desktop = {
      common.wayland = {
        enable = true;
        noctalia.monitors = {
          DVI-D-1 = {
            height = 1200;
            width = 1920;
          };
          HDMI-A-1 = {
            height = 1080;
            width = 1920;
          };
        };
        shell = "noctalia";
      };
      hyprland = {
        enable = true;
        startup-monitor = 1;
      };
    };
    feature-set = myLib.const.feature-sets.full;
    gpu = "nvidia";
    gui.enable = true;
    jetbrains.enable = true;
    media.enable = true;
    rust.extraTools = [ ];
    shell = {
      aliases = { };
      type = "zsh";
    };
    steam.enable = true;
    terminal = "wezterm";
    unity.enable = true;
  };
}
