{ myLib, ... }:
{
  ms0503 = {
    desktop = {
      common.wayland.enable = false;
      hyprland.enable = false;
    };
    feature-set = myLib.const.feature-sets.tiny;
    gpu = null;
    gui.enable = false;
    jetbrains.enable = false;
    media.enable = false;
    rust.extraTools = [ ];
    shell = {
      aliases = { };
      type = "zsh";
    };
    steam.enable = false;
    terminal = null;
    unity.enable = false;
  };
}
