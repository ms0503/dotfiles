{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.ms0503.unity;
in
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      alcom
      unityhub
    ];
  };
  options.ms0503.unity.enable = mkEnableOption "Unity and some applications";
}
