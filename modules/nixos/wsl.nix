{
  config,
  lib,
  username,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.ms0503.wsl;
in
{
  config = mkIf cfg.enable {
    wsl = {
      defaultUser = username;
      enable = true;
    };
  };
  options.ms0503.wsl.enable = mkEnableOption "WSL";
}
