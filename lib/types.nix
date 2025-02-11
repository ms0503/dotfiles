{ nixpkgs, ... }:
let
  inherit (nixpkgs.lib) types;
in
{
  gpus = types.enum [
    "none"
    "nvidia"
    "radeon"
  ];
  terminals = types.enum [
    "ghostty"
    "wezterm"
  ];
  walland = {
    backends = types.enum [
      "feh"
      "hyprpaper"
      "swaybg"
      "swww"
    ];
    sources = types.enum [
      "apod"
      "bing"
      "earthobservatory"
      "epod"
      "nasa"
      "national-geographic"
      "random"
      "unsplash"
    ];
  };
}
