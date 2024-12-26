{ config, lib, ... }:
lib.mkIf config.ms0503.media.enable {
  programs = {
    droidcam.enable = true;
    noisetorch.enable = true;
  };
}
# vim: et sts=2 sw=2 ts=2
