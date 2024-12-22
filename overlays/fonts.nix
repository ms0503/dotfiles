self:
prev@{
  fetchFromGitHub,
  lib,
  nixosTests,
  stdenvNoCC,
  ...
}:
let
  noto-cjk-pkgbase = typeface: old: {
    inherit (old) meta version;
    installPhase = ''
      local out_dir=$out/share/fonts/opentype/noto-cjk
      install -Dm444 -t "$out_dir" ${typeface}/Mono/*.otf
      install -Dm444 -t "$out_dir" ${typeface}/OTC/*.ttc
    '';
    passthru.tests.noto-fonts = nixosTests.noto-fonts;
    phases = [
      "installPhase"
    ];
    pname = "noto-fonts-cjk-${lib.toLower typeface}";
    src = fetchFromGitHub noto-cjk-repo;
  };
  noto-cjk-repo = {
    owner = "notofonts";
    repo = "noto-cjk";
    rev = "f8d157532fbfaeda587e826d4cd5b21a49186f7c";
    sha256 = "";
    sparseCheckout = [
      "Sans/Mono"
      "Sans/OTC"
      "Serif/OTC"
    ];
  };
  noto-fonts-repo = {
    owner = "notofonts";
    repo = "notofonts.github.io";
    rev = "2fa93b7aa9c2e4db0f9412e047e2481dfb1ef1b6";
    sha256 = "";
  };
in
{
  noto-fonts =
    let
      weights = "{Bold,BoldItalic,Italic,Light,LightItalic,Regular}";
    in
    stdenvNoCC.mkDerivation {
      inherit (prev.noto-fonts) meta version;
      installPhase = ''
        local out_dir=$out/share/fonts/truetype/noto
        install -Dm444 -t "$out_dir" fonts/NotoSans/unhinted/*/*-${weights}.ttf
        install -Dm444 -t "$out_dir" fonts/NotoSerif/unhinted/*/*-${weights}.ttf
        install -Dm444 -t "$out_dir" fonts/NotoSans/hinted/*/*-${weights}.ttf
        install -Dm444 -t "$out_dir" fonts/NotoSerif/hinted/*/*-${weights}.ttf
      '';
      phases = [
        "installPhase"
      ];
      pname = "noto-fonts";
      src = fetchFromGitHub noto-fonts-repo;
    };
  noto-fonts-cjk-sans = stdenvNoCC.mkDerivation (noto-cjk-pkgbase "Sans" prev.noto-fonts-cjk-sans);
  noto-fonts-cjk-serif = stdenvNoCC.mkDerivation (noto-cjk-pkgbase "Serif" prev.noto-fonts-cjk-serif);
}
# vim: et sts=2 sw=2 ts=2
