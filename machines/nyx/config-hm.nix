{ myLib, ... }:
{
  ms0503 = {
    desktop.hyprland = {
      enable = true;
      startup-monitor = 1;
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
    wayland.enable = true;
  };
}
