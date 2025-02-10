{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkForce mkIf;
  cfg = config.ms0503.secureboot;
in
{
  config = mkIf cfg.enable {
    boot = {
      lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };
      loader.systemd-boot.enable = mkForce false;
    };
    environment.systemPackages = with pkgs; [
      sbctl
    ];
  };
  options.ms0503.secureboot.enable = mkEnableOption "a secureboot";
}
