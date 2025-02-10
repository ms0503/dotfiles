{
  config,
  lib,
  myPkgs,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.ms0503.unity;
in
{
  config = mkIf cfg.enable {
    home.packages =
      (with pkgs; [
        unityhub
      ])
      ++ (with myPkgs; [
        alcom
      ]);
  };
  options.ms0503.unity.enable = mkEnableOption "Unity and some applications";
}
