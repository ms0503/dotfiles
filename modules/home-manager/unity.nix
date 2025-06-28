{
  config,
  lib,
  pkgs,
  pkgs2505,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.ms0503.unity;
in
{
  config = mkIf cfg.enable {
    home.packages =
      (with pkgs; [
        (alcom.overrideAttrs (
          _:
          {
            nativeBuildInputs ? [ ],
            postInstall ? "",
            ...
          }:
          {
            nativeBuildInputs =
              nativeBuildInputs
              ++ (with pkgs; [
                makeBinaryWrapper
              ]);
            # See https://github.com/tauri-apps/tauri/issues/10702
            postInstall =
              postInstall
              + lib.optionalString pkgs.stdenv.hostPlatform.isLinux ''
                wrapProgram "$out/bin/ALCOM" \
                  --set __GL_THREADED_OPTIMIZATIONS 0 \
                  --set __NV_DISABLE_EXPLICIT_SYNC 1
              '';
          }
        ))
      ])
      ++ (with pkgs2505; [
        (unityhub.override {
          extraLibs =
            pkgs: with pkgs; [
              openssl_1_1
            ];
        })
      ]);
  };
  options.ms0503.unity.enable = mkEnableOption "Unity and some applications";
}
