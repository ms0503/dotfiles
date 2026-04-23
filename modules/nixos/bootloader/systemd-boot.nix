{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.bootloader;
in
{
  config = mkIf (cfg.type == "systemd-boot" && cfg.efi.enable) {
    boot.loader.systemd-boot.enable = true;
  };
}
