{ lib, theme, ... }:
let
  colors = theme.colors;
in
{
  wayland.windowManager.hyprland.settings = {
    animations = {
      animation = [
        "windows, 1, 4, myBezier, slide"
        "layers, 1, 4, myBezier, fade"
        "border, 1, 5, default"
        "fade, 1, 5, default"
        "workspaces, 1, 6, default"
      ];
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
    };
    decoration = {
      blur = {
        enabled = true;
        ignore_opacity = true;
        new_optimizations = true;
        passes = 1;
        size = 3;
        xray = true;
      };
      rounding = 10;
    };
    dwindle = {
      preserve_split = true;
      pseudotile = true;
    };
    env = [
      "ELECTRON_OZONE_PLATFORM_HINT,auto"
      "GTK_IM_MODULE,fcitx"
      "LIBVA_DRIVER_NAME,nvidia"
      "NVD_BACKEND,direct"
      "QT_IM_MODULE,fcitx"
      "XMODIFIERS,@im=fcitx"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    ];
    exec-once = [
      "swww init && swww img ~/.config/hypr/wallpaper/bg.jpg"
      "fcitx5 -D"
      "discord-canary --start-minimized"
      "steam -silent"
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
      follow_mouse = 1;
      repeat_delay = 300;
      repeat_rate = 30;
      sensitivity = lib.mkDefault (-1.0);
    };
    master.new_status = "slave";
    misc.disable_hyprland_logo = true;
    windowrule = [
      "pseudo, noblur, class:(fcitx)"
    ];
    windowrulev2 = [
      "noblur,class:^()$,title:^()$"
    ];
  };
}
# vim: et sts=2 sw=2 ts=2
