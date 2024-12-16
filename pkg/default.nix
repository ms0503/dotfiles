pkgs: {
  colortool = pkgs.callPackage ./colortool { };
  generatehex = pkgs.callPackage ./generatehex { };
  getcodepoint = pkgs.callPackage ./getcodepoint { };
  getemoji = pkgs.callPackage ./getemoji { };
  matrics = pkgs.callPackage ./matrics { };
  unicodeescape = pkgs.callPackage ./unicodeescape { };
  urlencode = pkgs.callPackage ./urlencode { };
  urxvt-wrapper = pkgs.callPackage ./urxvt-wrapper { };
  waydroid-x11 = pkgs.callPackage ./waydroid-x11 { };
}
# vim: set et sts=2 sw=2 ts=2 :
