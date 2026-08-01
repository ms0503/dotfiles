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
  config = mkIf (cfg.type == "lanzaboote") {
    assertions = [
      {
        assertion = cfg.efi.enable;
        message = "ms0503.bootloader.efi.enable must be true";
      }
    ];
    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    environment.systemPackages = with pkgs; [
      sbctl
    ];
  };
}
