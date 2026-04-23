{ nixpkgs, ... }:
let
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
