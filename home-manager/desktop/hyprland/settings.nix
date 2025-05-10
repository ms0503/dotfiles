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
        "windows,1,4,myBezier,slide"
        "layers,1,4,myBezier,fade"
        "border,1,5,default"
        "fade,1,5,default"
        "workspaces,1,6,default"
      ];
      bezier = "myBezier,0.05,0.9,0.1,1.05";
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
    windowrulev2 = [
      "float,nofocus,class:^(jetbrains-.*)$,title:^(win[0-9]+)$"
      "pseudo,class:(fcitx)"
      "workspace 3 silent,class:^(discord)$"
    ];
    xwayland.force_zero_scaling = true;
  };
}
