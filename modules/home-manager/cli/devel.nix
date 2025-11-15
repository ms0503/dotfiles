{ config, pkgs, ... }:
let
  jdk17-wrapped = pkgs.stdenvNoCC.mkDerivation {
    inherit (pkgs.jdk17) version;
    installPhase = ''
      runHook preInstall
      install -dm755 "$out/lib"
      ln -s "$src/lib/openjdk" "$out/lib/openjdk17"
      runHook postInstall
    '';
    pname = "jdk17-wrapped";
    src = pkgs.jdk17;
  };
  jdk21-wrapped = pkgs.stdenvNoCC.mkDerivation {
    inherit (pkgs.jdk21) version;
    installPhase = ''
      runHook preInstall
      install -dm755 "$out/lib"
      ln -s "$src/lib/openjdk" "$out/lib/openjdk21"
      runHook postInstall
    '';
    pname = "jdk21-wrapped";
    src = pkgs.jdk21;
  };
  jdk8-wrapped = pkgs.stdenvNoCC.mkDerivation {
    inherit (pkgs.jdk8) version;
    installPhase = ''
      runHook preInstall
      install -dm755 "$out/lib"
      ln -s "$src/lib/openjdk" "$out/lib/openjdk8"
      runHook postInstall
    '';
    pname = "jdk8-wrapped";
    src = pkgs.jdk8;
  };
in
{
  home.packages =
    (with pkgs; [
      (fenix.combine (
        [
          fenix.latest.toolchain
          fenix.stable.toolchain
          fenix.targets.i686-unknown-linux-gnu.latest.rust-std
          fenix.targets.i686-unknown-linux-gnu.stable.rust-std
        ]
        ++ config.ms0503.rust.extraTools
      ))
      (lib.hiPrio gcc)
      (lib.hiPrio nodejs-slim)
      (lib.hiPrio python312)
      (lib.hiPrio rust-analyzer-nightly)
      arduino-cli
      clang
      cmake
      deno
      dotnet-sdk
      ghc
      jdk17-wrapped
      jdk21-wrapped
      jdk8-wrapped
      mold
      mono
      ninja
      uv
      zig
    ])
    ++ (with pkgs.nodePackages; [
      npm
      pnpm
      yarn
    ])
    ++ (with pkgs.python312Packages; [
      build
      setuptools
      wheel
    ]);
  programs = {
    bun.enable = true;
    go = {
      enable = true;
      env.GOBIN = ".local/bin";
    };
    java = {
      enable = true;
      package = pkgs.jdk23;
    };
  };
}
