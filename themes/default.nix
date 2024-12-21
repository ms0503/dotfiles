theme:
let
  removeHash = str: builtins.substring 1 (builtins.stringLength str) str;
in
rec {
  colors = builtins.mapAttrs (_: value: removeHash value) xcolors;
  fzf = builtins.readFile ./colors/${theme}/fzf.sh;
  xcolors = import ./colors/${theme};
}
# vim: et sts=2 sw=2 ts=2
