{
  config,
  inputs',
  lib,
  myLib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkOption;
  cfgGUI = config.ms0503.gui;
  cfgHyprland = config.ms0503.desktop.hyprland;
  types = lib.types // myLib.types;
in
{
  config = mkIf (cfgGUI.enable && cfgHyprland.enable) {
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
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;
    };
  };
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
  options.ms0503.desktop.hyprland.startup-monitor = mkOption {
    description = "Monitor ID that is used by startup";
    type = types.ints.unsigned;
  };
}
