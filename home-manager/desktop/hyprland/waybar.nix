{ theme, ... }:
let
  colors = theme.colors;
in
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        "clock#1" = {
          format = "{:%a}";
          tooltip = false;
        };
        "clock#2" = {
          format = "{:%H:%M}";
          tooltip = false;
        };
        "clock#3" = {
          format = "{:%m-%d}";
          tooltip = false;
        };
        "custom/left-arrow-dark" = {
          format = "";
          tooltip = false;
        };
        "custom/left-arrow-light" = {
          format = "";
          tooltip = false;
        };
        "custom/right-arrow-dark" = {
          format = "";
          tooltip = false;
        };
        "custom/right-arrow-light" = {
          format = "";
          tooltip = false;
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          on-scroll-up = "hyprctl dispatch workspace e+1";
        };
        battery = {
          format = "{icon} {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          states = {
            critical = 10;
            good = 90;
            warning = 20;
          };
        };
        cpu = {
          format = "CPU {usage:2}%";
          interval = 5;
        };
        disk = {
          format = "Disk {percentage_used:2}%";
          interval = 5;
          path = "/";
        };
        layer = "top";
        memory = {
          format = "Mem {}%";
          interval = 5;
        };
        modules-center = [
          "custom/left-arrow-dark"
          "clock#1"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "clock#2"
          "custom/right-arrow-dark"
          "custom/right-arrow-light"
          "clock#3"
          "custom/right-arrow-dark"
        ];
        modules-left = [
          "hyprland/workspaces"
          "custom/right-arrow-dark"
        ];
        modules-right = [
          "custom/left-arrow-dark"
          "pulseaudio"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "memory"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "cpu"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "battery"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "disk"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "tray"
        ];
        position = "top";
        pulseaudio = {
          format = "{icon} {volume:2}%";
          format-bluetooth = "{icon} {volume:2}%";
          format-icons = {
            default = [
              ""
              ""
            ];
            headphones = "";
          };
          format-muted = "MUTE";
          on-click = "pamixer -t";
          on-click-right = "pavucontrol";
          scroll-step = 5;
        };
        tray.icon-size = 20;
      };
    };
    style = ''
      * {
        font-family: monospace;
        font-size: 12px;
      }

      window#waybar {
        background: #${colors.bg};
        color: #${colors.fg};
      }

      #custom-left-arrow-dark,
      #custom-right-arrow-dark {
        color: #${colors.black};
      }

      #custom-left-arrow-light,
      #custom-right-arrow-light {
        background: #${colors.black};
        color: #${colors.bg};
      }

      #battery,
      #clock.1,
      #clock.2,
      #clock.3,
      #cpu,
      #disk,
      #memory,
      #pulseaudio,
      #tray,
      #workspaces {
        background: #${colors.black};
      }

      #battery {
        color: #${colors.green};
      }

      #cpu {
        color: #${colors.purple};
      }

      #disk {
        color: #${colors.magenta};
      }

      #memory {
        color: #${colors.teal};
      }

      #pulseaudio {
        color: #${colors.blue};
      }

      #workspaces button {
        color: #${colors.fg};
        padding: 0 4px;
      }

      #workspaces button.focused {
        color: #${colors.blue};
      }

      #workspaces button:hover {
        background: #${colors.black};
        border: #${colors.black};
        box-shadow: inherit;
        padding: 0 4px;
        text-shadow: inherit;
      }

      #battery,
      #clock,
      #cpu,
      #disk,
      #memory,
      #pulseaudio {
        padding: 0 12px;
      }
    '';
  };
}
# vim: et sts=2 sw=2 ts=2
