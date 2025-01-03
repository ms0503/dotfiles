{
  buildDotnetModule,
  cargo-about,
  cargo-tauri,
  dotnetCorePackages,
  fetchFromGitHub,
  fetchNpmDeps,
  glib-networking,
  google-fonts,
  lib,
  libsoup_3,
  nodePackages,
  nodejs-slim,
  npmHooks,
  openssl,
  pkg-config,
  rustPlatform,
  stdenvNoCC,
  webkitgtk_4_1,
}:
let
  cargoHash = "sha256-v9aNXafFj2vMM5VlKNfroK0mMi6021XUkoqkAXw2Trg=";
  dotnet-build = buildDotnetModule {
    inherit
      dotnet-runtime
      dotnet-sdk
      pname
      src
      version
      ;
    nugetDeps = ./deps.json;
    projectFile = [
      "vrc-get-litedb/dotnet/LiteDB/LiteDB/LiteDB.csproj"
      "vrc-get-litedb/dotnet/vrc-get-litedb.csproj"
    ];
  };
  dotnet-runtime = dotnetCorePackages.runtime_8_0;
  dotnet-sdk = dotnetCorePackages.sdk_8_0;
  google-fonts' = google-fonts.override {
    fonts = [
      "NotoSans"
      "NotoSansJP"
    ];
  };
  npmHash = "sha256-QAUoz/mzF9aDvkILKX3rxkYUC+VmJeRVjG8vJ/b0Dho=";
  pname = "alcom";
  sha256 = "ph9dJhm4DbI6/we/HD4T1LOafaWylhHoNT+zaYgl4f8=";
  src = fetchFromGitHub {
    inherit sha256;
    fetchSubmodules = true;
    owner = "vrc-get";
    repo = "vrc-get";
    rev = "gui-v${version}";
  };
  version = "0.1.17";
in
rustPlatform.buildRustPackage {
  inherit
    cargoHash
    pname
    src
    version
    ;
  buildAndTestSubdir = "vrc-get-gui";
  buildInputs =
    [
      openssl
    ]
    ++ lib.optionals stdenvNoCC.hostPlatform.isLinux [
      glib-networking
      libsoup_3
      webkitgtk_4_1
    ]
    ++ dotnet-sdk.packages
    ++ dotnet-build.nugetDeps;
  meta = {
    description = "Experimental GUI application to manage VRChat Unity Projects";
    homepage = "https://vrc-get.anatawa12.com";
    license = lib.licenses.mit;
    mainProgram = "alcom";
    platforms = [
      "x86_64-linux"
    ];
    sourceProvenance = with lib.sourceTypes; [
      fromSource
    ];
  };
  nativeBuildInputs = [
    cargo-about
    cargo-tauri.hook
    dotnet-sdk
    nodePackages.npm
    nodejs-slim
    npmHooks.npmConfigHook
    pkg-config
  ];
  npmDeps = fetchNpmDeps {
    inherit src;
    hash = npmHash;
    sourceRoot = "${src.name}/vrc-get-gui";
  };
  npmRoot = "vrc-get-gui";
  passthru = {
    inherit (dotnet-build) fetch-deps;
  };
  patches = [
    ./delete-get-commit-hash.patch
    ./fix-headless-unityhub-args.patch
  ];
  postPatch = ''
    install -Dm444 "${google-fonts'}/share/fonts/truetype/NotoSans[wdth,wght].ttf" vrc-get-gui/app/fonts/noto-sans.ttf
    install -Dm444 "${google-fonts'}/share/fonts/truetype/NotoSansJP[wght].ttf" vrc-get-gui/app/fonts/noto-sans-jp.ttf
  '';
  preConfigure = ''
    dotnet restore "vrc-get-litedb/dotnet/vrc-get-litedb.csproj" \
      -p:ContinuousIntegrationBuild=true \
      -p:Deterministic=true
  '';
}
