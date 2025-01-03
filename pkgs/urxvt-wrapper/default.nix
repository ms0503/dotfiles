{ stdenvNoCC }:
stdenvNoCC.mkDerivation {
  installPhase = "	install -dm755 $out/bin\n	install -Dm755 urxvt-wrapper $out/bin/urxvt-wrapper\n";
  name = "urxvt-wrapper";
  src = ./.;
}

