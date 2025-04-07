{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.arch;
in
{
  config = mkIf (cfg == "x86_64") {
    boot.binfmt.emulatedSystems = [
      "aarch64-linux"
      "armv7l-linux"
      "i686-windows"
      "wasm32-wasi"
      "wasm64-wasi"
      "x86_64-windows"
    ];
  };
}
