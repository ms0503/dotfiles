{ callPackage, ... }:
rec {
  microsoft-edge-dev = callPackage ./microsoft-edge-dev { };
  milk-cursor-themes = callPackage ./milk-cursor-themes { inherit zifu; };
  urxvt-wrapper = callPackage ./urxvt-wrapper { };
  zifu = callPackage ./zifu { };
}
# vim: et sts=2 sw=2 ts=2
