{
  makeRustPlatform,
  openssl,
  pkg-config,
  rust-bin,
}:
let
  toolchain = rust-bin.nightly.latest.default;
  rustPlatform = makeRustPlatform {
    cargo = toolchain;
    rustc = toolchain;
  };
in
rustPlatform.buildRustPackage {
  buildInputs = [ openssl ];
  cargoLock.lockFile = ./Cargo.lock;
  nativeBuildInputs = [ pkg-config ];
  pname = "getemoji";
  src = ./.;
  version = "0.1.0";
}
# vim: set et sts=2 sw=2 ts=2 :
