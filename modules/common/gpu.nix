{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.ms0503.gpu = mkOption {
    description = "GPU family.";
    type = types.nullOr (
      types.enum [
        "nvidia"
        "radeon"
      ]
    );
  };
}
