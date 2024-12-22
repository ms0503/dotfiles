{ callPackage, ... }:
{
  colortool = callPackage ./colortool { };
  generatehex = callPackage ./generatehex { };
  getcodepoint = callPackage ./getcodepoint { };
  getemoji = callPackage ./getemoji { };
  matrics = callPackage ./matrics { };
  unicodeescape = callPackage ./unicodeescape { };
  urlencode = callPackage ./urlencode { };
  urxvt-wrapper = callPackage ./urxvt-wrapper { };
}
# vim: et sts=2 sw=2 ts=2
