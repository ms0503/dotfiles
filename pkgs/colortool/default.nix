{ rustPlatform }:
rustPlatform.buildRustPackage {
  cargoLock.lockFile = ./Cargo.lock;
  pname = "colortool";
  src = ./.;
  version = "0.1.0";
}
# vim: et sts=2 sw=2 ts=2
