{ callPackage, ... }:
{
  colortool = callPackage ./colortool { };
  generatehex = callPackage ./generatehex { };
  getcodepoint = callPackage ./getcodepoint { };
  getemoji = callPackage ./getemoji { };
  matrics = callPackage ./matrics { };
  microsoft-edge-dev = callPackage ./microsoft-edge-dev { };
  milk-cursor-themes = callPackage ./milk-cursor-themes { };
  unicodeescape = callPackage ./unicodeescape { };
  urlencode = callPackage ./urlencode { };
  urxvt-wrapper = callPackage ./urxvt-wrapper { };
  zifu = callPackage ./zifu { };
}
# vim: et sts=2 sw=2 ts=2
