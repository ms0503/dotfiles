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
    "class:.*\\.x86_64"
    "class:Minecraft.*"
    "class:Unity"
    "class:VirtualBox Machine"
    "class:[Bb]lender"
    "class:gimp"
    "class:hoi4"
    "class:msedge-_cmkncekebbebpfilplodngbpllndjkfo-Default" # Chrome Remote Desktop
    "class:steam_app_[0-9]+"
    "content:game"
    "content:photo"
    "content:video"
    "title:.*YouTube.*"
    "title:.*\\.avif \\([0-9]+×[0-9]+\\).*"
    "title:.*\\.bmp \\([0-9]+×[0-9]+\\).*"
    "title:.*\\.gif \\([0-9]+×[0-9]+\\).*"
    "title:.*\\.jpe?g \\([0-9]+×[0-9]+\\).*"
    "title:.*\\.png \\([0-9]+×[0-9]+\\).*"
    "title:.*\\.webp \\([0-9]+×[0-9]+\\).*"
    "title:.*ニコニコ動画.*"
  ];
  generateOpaqueWindowRules = builtins.map (win: "opacity 1 override, ${win}");
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
          scroll_factor = lib.mkDefault 0.7;
        };
      };
      master.new_status = "slave";
      misc.disable_hyprland_logo = true;
      windowrule = [
        "float, class:^$, title:^$"
        "float, class:jetbrains-.*, title:win[0-9]+"
        "float, class:kicad, title:.* — シンボル エディター"
        "float, class:kicad, title:.* — フットプリント エディター"
        "float, class:kicad, title:シンボル選択.*"
        "float, class:kicad, title:フットプリントを割り当て"
        "nofocus, class:^$, title:^$"
        "nofocus, class:jetbrains-.*, title:win[0-9]+"
        "pseudo, class:fcitx"
      ]
      ++ generateOpaqueWindowRules force-opaque-windows;
      xwayland.force_zero_scaling = true;
    };
  };
}
