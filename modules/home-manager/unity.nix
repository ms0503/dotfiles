{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf optionalString;
  cfg = config.ms0503.unity;
in
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (alcom.overrideAttrs (
        _:
        {
          nativeBuildInputs ? [ ],
          postInstall ? "",
          ...
        }:
        {
          nativeBuildInputs = builtins.concatLists [
            nativeBuildInputs
            (with pkgs; [
              makeBinaryWrapper
            ])
          ];
          # See https://github.com/tauri-apps/tauri/issues/10702
          postInstall =
            postInstall
            + optionalString pkgs.stdenv.hostPlatform.isLinux ''
              wrapProgram "$out/bin/ALCOM" \
                --set __GL_THREADED_OPTIMIZATIONS 0 \
                --set __NV_DISABLE_EXPLICIT_SYNC 1
            '';
        }
      ))
      unityhub
    ];
  };
  options.ms0503.unity.enable = mkEnableOption "Unity and some applications";
}
