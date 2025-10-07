{ config, lib, ... }:
let
  inherit (lib) mkIf optionals;
  cfg = config.ms0503.arch;
  cfgWsl = config.ms0503.wsl;
in
{
  config = mkIf (cfg == "x86_64") {
    boot.binfmt.emulatedSystems = [
      "aarch64-linux"
      "armv7l-linux"
      "wasm32-wasi"
      "wasm64-wasi"
    ]
    ++ optionals (!cfgWsl.enable) [
      "i686-windows"
      "x86_64-windows"
    ];
  };
}
