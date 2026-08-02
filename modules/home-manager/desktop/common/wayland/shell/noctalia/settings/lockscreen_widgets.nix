{ config, lib, ... }:
let
  cfg = config.ms0503.desktop.common.wayland.noctalia;
in
{
  enabled = true;
  grid = {
    cell_size = 16;
    major_interval = 4;
    visible = true;
  };
  schema_version = 2;
  widget =
    cfg.monitors
    |> builtins.mapAttrs (
      name: mon: {
        "clock-main@${name}" = {
          box_height = 128.0;
          box_width = 256.0;
          cx = mon.width / 2.0;
          cy = mon.height / 2.0;
          rotation = 0.0;
          settings = {
            background_color = "surface_variant";
            background_opacity = 0.88;
            background_radius = 12.0;
            center_text = true;
            clock_style = "digital";
            format = "%H:%M";
            timezone = "";
          };
          type = "clock";
        };
        "login-box@${name}" = {
          box_height = 196.0;
          box_width = 810.0;
          cx = mon.width / 2.0;
          cy = mon.height - 182.0;
          rotation = 0.0;
          settings = {
            background_color = "surface_variant";
            background_opacity = 0.88;
            background_radius = 12.0;
            center_password_text = false;
            input_opacity = 1.0;
            input_radius = 6.0;
            layout = "regular";
            show_caps_lock = true;
            show_keyboard_layout = true;
            show_login_button = true;
            show_media = true;
            show_session_buttons = true;
            show_unlock_hint = true;
            show_weather = true;
          };
          type = "login_box";
        };
      }
    )
    |> builtins.attrValues
    |> builtins.foldl' (acc: elem: acc // elem) { };
  widget_order =
    cfg.monitors
    |> builtins.attrNames
    |> builtins.map (name: [
      "clock-main@${name}"
      "login-box@${name}"
    ])
    |> lib.flatten;
}
