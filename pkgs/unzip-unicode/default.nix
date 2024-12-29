{ fetchurl, unzip }:
unzip.overrideAttrs (
  self: super: {
    patches = super.patches ++ [
      (fetchurl {
        name = "20-unzip60-alt-iconv-utf8.patch";
        sha256 = "525tbsmc0sg5cwBR6EHCh3o0Cg3kqPseT6PQZnmWpBw=";
        url = "https://git.launchpad.net/ubuntu/+source/unzip/plain/debian/patches/20-unzip60-alt-iconv-utf8.patch?id=4b84f6f7b2bb169583ab3a6f542528f1c2c0ad7b";
      })
      (fetchurl {
        name = "30-fix-code-pages.patch";
        sha256 = "wcotXp0z+QjrRyGlT6Unxa/7i9shecIzQ3eWZb5+TdM=";
        url = "https://git.launchpad.net/ubuntu/+source/unzip/plain/debian/patches/30-fix-code-pages.patch?id=4b84f6f7b2bb169583ab3a6f542528f1c2c0ad7b";
      })
    ];
    pname = "unzip-unicode";
    preConfigure = ''
      ${super.preConfigure}
      sed -i -E 's/CF="(.*)"/CF="\1 -DUNICODE_SUPPORT -DUTF8_MAYBE_NATIVE"/' unix/Makefile
    '';
  }
)
# vim: et sts=2 sw=2 ts=2
