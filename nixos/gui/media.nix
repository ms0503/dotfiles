{ config, lib, ... }:
lib.mkIf config.ms0503.media.enable {
  programs = {
    droidcam.enable = true;
    noisetorch.enable = true;
  };
}
