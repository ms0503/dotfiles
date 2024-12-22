{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc-ut
      fcitx5-tokyonight
    ];
    type = "fcitx5";
  };
}
# vim: et sts=2 sw=2 ts=2
