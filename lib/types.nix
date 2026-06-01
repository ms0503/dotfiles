{ inputs, ... }:
let
  inherit (inputs) nixpkgs;
  inherit (nixpkgs.lib) types;
in
{
  bootloaders = types.enum [
    ""
    "grub"
    "lanzaboote"
    "systemd-boot"
  ];
  gpus = types.enum [
    "none"
    "nvidia"
    "radeon"
  ];
  ims = types.enum [
    "hazkey"
    "karukan"
    "mozc"
    "mozc-ut"
    "mozkey"
  ];
  shells = types.enum [
    "bash"
    "zsh"
  ];
  terminals = types.enum [
    ""
    "ghostty"
    "wezterm"
  ];
}
