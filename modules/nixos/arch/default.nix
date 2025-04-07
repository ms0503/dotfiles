{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  imports = [
    ./x86_64.nix
  ];
  options.ms0503.arch = mkOption {
    description = "Machine architecture.";
    example = "x86_64";
    type = types.enum [
      "x86_64"
    ];
  };
}
