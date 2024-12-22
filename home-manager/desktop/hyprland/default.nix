{ inputs, pkgs, ... }:
{
  home.packages =
    (with pkgs; [
      brightnessctl
      grimblast
      hyprpicker
      pamixer
      playerctl
      swww
      wev
      wf-recorder
      wl-clipboard
    ])
    ++ [
      inputs.hyprsome.packages.${pkgs.system}.default
    ];
  imports = [
    ./dunst.nix
    ./key-binds.nix
    ./settings.nix
    ./swaylock.nix
    ./waybar.nix
    ./wlogout.nix
    ./wofi.nix
  ];
  wayland.windowManager.hyprland.enable = true;
}
# vim: et sts=2 sw=2 ts=2
