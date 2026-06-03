{ lib, ... }:
let
  inherit (lib) mkEnableOption mkOption types;
in
{
  imports = [
    ./grub.nix
    ./lanzaboote.nix
    ./systemd-boot.nix
  ];
  options.ms0503.bootloader = {
    efi.enable = mkEnableOption "an EFI";
    type = mkOption {
      description = "Choose a bootloader";
      type = types.nullOr (
        types.enum [
          "grub"
          "lanzaboote"
          "systemd-boot"
        ]
      );
    };
  };
}
