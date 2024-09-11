{ makeRustPlatform, rust-bin }: let
  toolchain = rust-bin.nightly.latest.default;
  rustPlatform = makeRustPlatform {
    cargo = toolchain;
    rustc = toolchain;
  };
in rustPlatform.buildRustPackage {
  cargoLock.lockFile = ./Cargo.lock;
  pname = "getcodepoint";
  src = ./.;
  version = "0.1.0";
}
/* vim: set sts=2 sw=2 ts=2 : */
