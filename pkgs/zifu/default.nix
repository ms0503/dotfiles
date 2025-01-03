{ fetchFromGitHub, rustPlatform }:
let
  cargoHash = "sha256-mBXXftmwEKq1ClgLwrWzKE5PdV6WnMCso4fso4ANS+k=";
  sha256 = "zedt272khGod2zy7SdJ+I4MLHFrQa7BUAol9lrs7R6o=";
  version = "1.1.0";
in
rustPlatform.buildRustPackage {
  inherit cargoHash version;
  pname = "zifu";
  src = fetchFromGitHub {
    inherit sha256;
    owner = "tats-u";
    repo = "zifu";
    rev = "v${version}";
  };
}
