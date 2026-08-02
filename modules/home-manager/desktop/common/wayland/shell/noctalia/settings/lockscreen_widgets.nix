_: {
  enabled = true;
  grid = {
    cell_size = 16;
    major_interval = 4;
    visible = true;
  };
  schema_version = 2;
  widget = {
    clock-main = {
      box_height = 128.0;
      box_width = 256.0;
      cx = 960.0;
      cy = 524.0;
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
    login-box = {
      box_height = 196.0;
      box_width = 810.0;
      cx = 960.0;
      cy = 898.0;
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
  };
  widget_order = [
    "clock-main"
    "login-box"
  ];
}
