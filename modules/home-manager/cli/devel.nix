{
  config,
  lib,
  myLib,
  pkgs,
  ...
}:
let
  inherit (config.ms0503) feature-set;
  inherit (lib) hiPrio optionalAttrs optionals;
  inherit (myLib) const;
  jdk17-wrapped = pkgs.stdenvNoCC.mkDerivation {
    inherit (pkgs.jdk17) version;
    installPhase = ''
      runHook preInstall
      install -dm755 "$out/lib"
      ln -s "$src" "$out/lib/openjdk17"
      runHook postInstall
    '';
    pname = "jdk17-wrapped";
    src = pkgs.temurin-bin-17;
  };
  jdk21-wrapped = pkgs.stdenvNoCC.mkDerivation {
    inherit (pkgs.jdk21) version;
    installPhase = ''
      runHook preInstall
      install -dm755 "$out/lib"
      ln -s "$src" "$out/lib/openjdk21"
      runHook postInstall
    '';
    pname = "jdk21-wrapped";
    src = pkgs.temurin-bin-21;
  };
  jdk8-wrapped = pkgs.stdenvNoCC.mkDerivation {
    inherit (pkgs.jdk8) version;
    installPhase = ''
      runHook preInstall
      install -dm755 "$out/lib"
      ln -s "$src" "$out/lib/openjdk8"
      runHook postInstall
    '';
    pname = "jdk8-wrapped";
    src = pkgs.temurin-bin-8;
  };
in
{
  home.packages =
    (with pkgs; [
      (hiPrio gcc)
      (hiPrio nodejs-slim_latest)
      (yarn-berry.override {
        nodejs = nodejs_latest;
      })
      clang
      cmake
      mold
      ninja
      uv
    ])
    ++ (with pkgs.nodePackages; [
      npm
      pnpm
    ])
    ++ (with pkgs.python312Packages; [
      build
      python
      setuptools
      wheel
    ])
    ++ optionals (const.feature-sets.lite <= feature-set) (
      with pkgs;
      [
        (fenix.combine (
          [
            fenix.latest.toolchain
          ]
          ++ optionals (const.feature-sets.full <= feature-set) [
            fenix.stable.toolchain
            fenix.targets.i686-unknown-linux-gnu.latest.rust-std
            fenix.targets.i686-unknown-linux-gnu.stable.rust-std
          ]
          ++ config.ms0503.rust.extraTools
        ))
        (hiPrio rust-analyzer-nightly)
        arduino-cli
        deno
        dotnet-sdk
        ghc
        jdk17-wrapped
        jdk21-wrapped
        jdk8-wrapped
        mono
        zig
      ]
    );
  programs = {
    java = {
      enable = true;
      package = pkgs.jre25_minimal;
    };
  }
  // optionalAttrs (const.feature-sets.lite <= feature-set) {
    bun.enable = true;
    go = {
      enable = true;
      env.GOBIN = ".local/bin";
    };
    java = {
      enable = true;
      package = pkgs.temurin-bin-25;
    };
  };
}
