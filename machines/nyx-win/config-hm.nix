{ myLib, ... }:
{
  ms0503 = {
    desktop.hyprland.enable = false;
    feature-set = myLib.const.feature-sets.lite;
    gpu = "nvidia";
    gui.enable = true;
    jetbrains.enable = false;
    media.enable = false;
    rust.extraTools = [ ];
    shell = {
      aliases = { };
      type = "zsh";
    };
    steam.enable = false;
    terminal = "wezterm";
    unity.enable = false;
    wayland.enable = true;
  };
}
