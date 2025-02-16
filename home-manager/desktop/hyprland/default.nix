{ inputs', pkgs, ... }:
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
      inputs'.hyprsome.packages.default
    ];
  imports = [
    ./autostart.nix
    ./dunst.nix
    ./gestures.nix
    ./key-binds.nix
    ./settings.nix
    ./swaylock.nix
    ./waybar.nix
    ./wofi.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
  };
}
