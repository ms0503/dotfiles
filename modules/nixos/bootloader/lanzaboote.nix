{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.bootloader;
in
{
  config = mkIf (cfg.type == "lanzaboote" && cfg.efi.enable) {
    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    environment.systemPackages = with pkgs; [
      sbctl
    ];
  };
}
