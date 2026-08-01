{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.bootloader;
in
{
  config = mkIf (cfg.type == "systemd-boot") {
    assertions = [
      {
        assertion = cfg.efi.enable;
        message = "ms0503.bootloader.efi.enable must be true";
      }
    ];
    boot.loader.systemd-boot.enable = true;
  };
}
