{ config, pkgs, ... }:
{
  home.packages = if config.ms0503.unity.enable then (with pkgs; [
    alcom
    unityhub
  ]) else [];
}
# vim: et sts=2 sw=2 ts=2
