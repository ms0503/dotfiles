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
}
