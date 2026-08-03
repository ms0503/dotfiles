{ config, ... }: {
  default = {
    auto_hide = false;
    background_opacity = 1.0;
    border_width = 0.0;
    capsule = false;
    center = [
      "clock"
    ];
    concave_edge_corners = true;
    contact_shadow = false;
    dead_zone.actions = {
      back = "media previous";
      forward = "media next";
      left = "panel-toggle launcher";
      middle = "exec ${config.ms0503.terminalCmd}";
      scroll_down = "volume-down";
      scroll_left = "media previous";
      scroll_right = "media next";
      scroll_up = "volume-up";
    };
    enabled = true;
    end = [
      "volume"
      "brightness"
      "battery"
      "network"
      "bluetooth"
      "tray"
      "clipboard"
      "notifications"
      "control-center"
      "session"
    ];
    font_family = "";
    font_weight = 500;
    hover_highlight = true;
    layer = "top";
    margin_edge = 0;
    margin_ends = 100;
    margin_opposite_edge = 0;
    padding = 14;
    panel_overlap = 1;
    position = "top";
    radius = 12;
    reserve_space = true;
    scale = 1.0;
    shadow = true;
    smart_auto_hide = false;
    start = [
      "workspaces"
    ];
    thickness = 34;
    widget_spacing = 6;
  };
  order = [
    "main"
  ];
}
