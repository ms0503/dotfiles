{ username, ... }: {
  automation = {
    enabled = true;
    interval_seconds = 1800;
    order = "random";
    recursive = true;
  };
  default.path = "/home/${username}/Pictures/wallpaper/default.webp";
  directory = "/home/${username}/Pictures/wallpaper";
  edge_smoothness = 0.3;
  enabled = true;
  fill_mode = "crop";
  per_monitor_directories = false;
  transition = [ ];
  transition_duration = 1500;
  transition_on_startup = false;
}
