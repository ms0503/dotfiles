{ theme, ... }:
with theme.xcolors;
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        background = black;
        corner_radius = 10;
        font = "Noto Sans CJK JP";
        foreground = fg;
        frame_color = black;
        monitor = 1;
        offset = "30x30";
        timeout = 10;
        transparency = 10;
      };
      urgency_critical.frame_color = red;
    };
  };
}
# vim: et sts=2 sw=2 ts=2
