{
  lib,
  theme,
  ...
}:
let
  inherit (theme) colors;
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
      "pseudo, noblur, class:(fcitx)"
    ];
    windowrulev2 = [
      "noblur,class:^()$,title:^()$"
    ];
    xwayland.force_zero_scaling = true;
  };
}
