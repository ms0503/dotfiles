{ lib, myLib, ... }:
let
  inherit (lib) mkEnableOption mkOption;
  types = lib.types // myLib.types;
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
      type = types.bootloaders;
    };
  };
}
