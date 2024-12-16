{stdenvNoCC}: stdenvNoCC.mkDerivation {
	installPhase = ''
		install -dm755 $out/bin
		install -Dm755 urxvt-wrapper $out/bin/urxvt-wrapper
	'';
	name = "urxvt-wrapper";
	src = ./.;
}

/* vim: set et sts=2 sw=2 ts=2 : */
