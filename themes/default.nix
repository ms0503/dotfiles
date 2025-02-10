theme:
let
  removeHash = str: builtins.substring 1 (builtins.stringLength str) str;
in
rec {
  colors = builtins.mapAttrs (_: value: removeHash value) xcolors;
  fzf = builtins.readFile ./colors/${theme}/fzf.sh;
  ghostty = import ./colors/${theme}/ghostty.nix;
  wezterm = builtins.readFile ./colors/${theme}/wezterm.toml;
  xcolors = import ./colors/${theme};
}
