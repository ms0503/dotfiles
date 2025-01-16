{ config, pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc-ut
        fcitx5-tokyonight
      ];
      waylandFrontend = config.ms0503.wayland.enable;
    };
    type = "fcitx5";
  };
}
