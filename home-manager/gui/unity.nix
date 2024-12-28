{ config, pkgs, ... }:
pkgs.lib.mkIf config.ms0503.unity.enable {
  home.packages = with pkgs; [
    alcom
    unityhub
  ];
}
# vim: et sts=2 sw=2 ts=2
