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
  shells = types.enum [
    "bash"
    "zsh"
  ];
  terminals = types.enum [
    "ghostty"
    "wezterm"
  ];
}
