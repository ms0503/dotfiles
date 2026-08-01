{ config, ... }: {
  animation = {
    enabled = true;
    speed = 1.0;
  };
  app_icon_color = "on_surface_variant";
  app_icon_colorize = true;
  button_borders = true;
  card_borders = true;
  clipboard_auto_paste = "auto";
  clipboard_confirm_clear_history = true;
  clipboard_enabled = true;
  clipboard_history_max_entries = 100;
  clipboard_image_action_command = "gimp {path}";
  clipboard_keep_from_closed_apps = true;
  corner_radius_scale = 1.0;
  date_format = "%Y-%m-%d (%a)";
  disable_mipmaps = false;
  external_ip_enabled = false;
  font_family = "Noto Sans CJK JP,Noto Sans,Sans,Noto Color Emoji";
  greeter_sync.auto_sync = false;
  hot_corners.enabled = false;
  input_borders = true;
  lang = "ja_JP.UTF-8";
  launch_apps_as_systemd_services = true;
  launch_apps_custom_command = "uwsm app -- $CMD";
  launcher = {
    app_grid = false;
    auto_paste = "auto";
    categories = true;
    compact = false;
    dmenu.entry.ssh = {
      command = "awk '/^Host / { print $2 }' ~/.ssh/config";
      exec = "${config.ms0503.terminalSsh} {selection}";
      global = false;
      glyph = "server";
      prefix = "ssh";
    };
    fetch_exchange_rates = true;
    provider_prefix = "/";
    providers = {
      calculator = {
        global = true;
        prefix = "calc";
      };
      emoji = {
        global = false;
        prefix = "emj";
      };
      session = {
        global = false;
        prefix = "session";
      };
      wallpaper = {
        global = false;
        prefix = "wall";
      };
      windows = {
        global = false;
        prefix = "win";
      };
    };
    show_icons = true;
    sort_by_usage = true;
  };
  mpris.blacklist = [ ];
  offline_mode = false;
  panel = {
    borders = true;
    clipboard_placement = "floating";
    clipboard_position = "center";
    control_center_placement = "attatched";
    floating_layer = "overlay";
    floating_offset = 8;
    launcher_placement = "floating";
    launcher_position = "center";
    list_item_background = false;
    open_near_click_clipboard = false;
    open_near_click_control_center = false;
    open_near_click_launcher = false;
    open_near_click_session = false;
    open_near_click_wallpaper = false;
    polkit_placement = "floating";
    polkit_position = "center";
    session_placement = "attached";
    shadow = true;
    transparency_mode = "glass";
    wallpaper_placement = "attached";
  };
  password_style = "default";
  polkit_agent = true;
  popup_borders = true;
  popup_shadows = true;
  privacy = {
    cam_filter_regex = "";
    mic_filter_regex = "";
    screen_filter_regex = "";
  };
  screen_corners.enabled = false;
  screen_time_enabled = true;
  screenshot = {
    confirm_region = false;
    copy_to_clipboard = true;
    directory = "~/Pictures/Screenshots";
    filename_pattern = "%Y-%m-%dT%H-%M-%S";
    freeze_screen = true;
    pipe_to_command = false;
    remember_last_region = false;
    save_to_file = true;
    show_cursor = false;
  };
  session = {
    actions = [ ];
    grid = false;
    power = {
      reboot = "sudo -n reboot";
      shutdown = "sudo -n poweroff";
      suspend = "sudo -n systemctl suspend";
    };
    show_shortcuts = true;
  };
  settings_show_advanced = true;
  setup_wizard_enabled = true;
  shadow = {
    alpha = 0.55;
    direction = "down";
  };
  shared_gl_context = true;
  show_location = true;
  telemetry_enabled = true;
  time_format = "%H:%M:%S";
}
