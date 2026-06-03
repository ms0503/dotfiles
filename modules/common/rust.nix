{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.ms0503.rust.extraTools = mkOption {
    description = "Extra Rust tools.";
    type = types.listOf types.package;
  };
}
