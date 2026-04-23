{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.bootloader;
in
{
  config = mkIf (cfg.type == "grub") {
    boot.loader.grub = {
      efiSupport = cfg.efi.enable;
      enable = true;
    };
  };
}
