{ lib, myLib, ... }:
let
  inherit (lib) mkOption;
  types = lib.types // myLib.types;
in
{
  options.ms0503.terminal = mkOption {
    description = "Choose a terminal emulator";
    type = types.terminals;
  };
}
