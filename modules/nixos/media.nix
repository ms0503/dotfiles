{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.media;
in
{
  config = mkIf cfg.enable {
    programs = {
      droidcam.enable = true;
      noisetorch.enable = true;
    };
  };
}
