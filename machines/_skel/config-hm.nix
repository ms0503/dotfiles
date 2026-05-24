{ myLib, ... }:
{
  ms0503 = {
    desktop.hyprland = {
      enable = false;
      startup-monitor = 0;
    };
    feature-set = myLib.const.feature-sets.tiny;
    gpu = "none";
    gui.enable = false;
    jetbrains.enable = false;
    media.enable = false;
    rust.extraTools = [ ];
    shell = {
      aliases = { };
      type = "zsh";
    };
    steam.enable = false;
    terminal = "";
    unity.enable = false;
    wayland.enable = false;
  };
}
