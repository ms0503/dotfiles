{
  config,
  lib,
  theme,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (theme) colors;
  cfg = config.ms0503.desktop.hyprland;
  cfgGui = config.ms0503.gui;
  force-opaque-windows = [
    "match:class .*\\.x86_64"
    "match:class Minecraft.*"
    "match:class Unity"
    "match:class VirtualBox Machine"
    "match:class [Bb]lender"
    "match:class gimp"
    "match:class hoi4"
    "match:class msedge-_cmkncekebbebpfilplodngbpllndjkfo-Default" # Chrome Remote Desktop
    "match:class steam_app_[0-9]+"
    "match:content game"
    "match:content photo"
    "match:content video"
    "match:title .*YouTube.*"
    "match:title .*\\.avif \\([0-9]+×[0-9]+\\).*"
    "match:title .*\\.bmp \\([0-9]+×[0-9]+\\).*"
    "match:title .*\\.gif \\([0-9]+×[0-9]+\\).*"
    "match:title .*\\.jpe?g \\([0-9]+×[0-9]+\\).*"
    "match:title .*\\.png \\([0-9]+×[0-9]+\\).*"
    "match:title .*\\.webp \\([0-9]+×[0-9]+\\).*"
    "match:title .*ニコニコ動画.*"
  ];
  generateOpaqueWindowRules = builtins.map (win: "${win}, opaque on");
in
{
  config = mkIf (cfgGui.enable && cfg.enable) {
    wayland.windowManager.hyprland.settings = {
      animations = {
        animation = [
          "border, 1, 5, default"
          "fade, 1, 5, default"
          "layers, 1, 4, myBezier, fade"
          "windows, 1, 4, myBezier, slide"
          "workspaces, 1, 6, default"
        ];
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      };
      decoration = {
        active_opacity = 0.9;
        blur.enabled = false;
        fullscreen_opacity = 0.9;
        inactive_opacity = 0.95;
        rounding = 10;
      };
      dwindle = {
        preserve_split = true;
        pseudotile = true;
      };
      ecosystem.no_update_news = true;
      env = [
        "ELECTRON_OZONE_PLATFORM_HINT, auto"
      ];
      general = {
        "col.active_border" = "rgb(${colors.blue})";
        "col.inactive_border" = "rgb(${colors.bg})";
        border_size = 2;
        gaps_in = 5;
        gaps_out = 5;
        resize_on_border = true;
      };
      input = {
        accel_profile = "adaptive";
        follow_mouse = 1;
        numlock_by_default = false;
        repeat_delay = 300;
        repeat_rate = 30;
        touchpad = {
          natural_scroll = true;
          scroll_factor = lib.mkDefault 0.1;
        };
      };
      master.new_status = "slave";
      misc.disable_hyprland_logo = true;
      windowrule = [
        "match:class ^$, match:title ^$, float on, no_focus on"
        "match:class fcitx, pseudo on"
        "match:class jetbrains-.*, match:title win[0-9]+, float on, no_focus on"
        "match:class kicad, match:title .* — フットプリント エディター, float on"
        "match:class kicad, match:title シンボル選択.*, float on"
        "match:class kicad, match:title フットプリントを割り当て, float on"
        "match:class kicad, match:title .* — シンボル エディター, float on"
      ]
      ++ generateOpaqueWindowRules force-opaque-windows;
      xwayland.force_zero_scaling = true;
    };
  };
}
