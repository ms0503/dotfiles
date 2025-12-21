{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.ms0503.jetbrains;
in
{
  config = mkIf cfg.enable {
    home.packages = with pkgs.jetbrains; [
      clion
      gateway
      idea
      rider
      webstorm
    ];
  };
  options.ms0503.jetbrains.enable = mkEnableOption "JetBrains IDEs";
}
