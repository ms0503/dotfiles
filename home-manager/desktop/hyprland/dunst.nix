{ theme, ... }:
let
  inherit (theme) xcolors;
in
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        background = xcolors.black;
        corner_radius = 10;
        font = "Noto Sans CJK JP";
        foreground = xcolors.fg;
        frame_color = xcolors.black;
        monitor = 1;
        offset = "30x30";
        timeout = 10;
        transparency = 10;
      };
      urgency_critical.frame_color = xcolors.red;
    };
  };
}
