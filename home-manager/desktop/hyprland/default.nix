{ inputs, pkgs, ... }:
{
  home.packages =
    (with pkgs; [
      brightnessctl
      grimblast
      hyprcursor
      hyprpicker
      pamixer
      playerctl
      swww
      wev
      wf-recorder
      wl-clipboard
      wlogout
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
    ./wofi.nix
  ];
  wayland.windowManager.hyprland.enable = true;
}
# vim: et sts=2 sw=2 ts=2
