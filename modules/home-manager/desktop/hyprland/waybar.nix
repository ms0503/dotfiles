{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfgGUI = config.ms0503.gui;
  cfgHyprland = config.ms0503.desktop.hyprland;
in
{
  config = mkIf (cfgGUI.enable && cfgHyprland.enable) {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          "clock#1" = {
            format = "{:%a}";
            tooltip = false;
          };
          "clock#2" = {
            format = "{:%H:%M:%S}";
            interval = 1;
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
          tray.icon-size = 14;
        };
      };
      style = ''
        * {
          font-family: monospace;
          font-size: 14px;
        }

        window#waybar {
          background: #333333;
          color: #dddddd;
        }

        #custom-left-arrow-dark,
        #custom-left-arrow-light,
        #custom-right-arrow-dark,
        #custom-right-arrow-light {
          border-bottom: 4px solid transparent;
          border-top: 4px solid transparent;
        }

        #custom-left-arrow-dark,
        #custom-right-arrow-dark {
          color: #222222;
        }

        #custom-left-arrow-light,
        #custom-right-arrow-light {
          background: #222222;
          color: #333333;
        }

        #custom-left-arrow-dark {
          border-right: 4px solid #222222;
        }

        #custom-left-arrow-light {
          border-right: 4px solid #333333;
        }

        #custom-right-arrow-dark {
          border-left: 4px solid #222222;
        }

        #custom-right-arrow-light {
          border-left: 4px solid #333333;
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
          background: #222222;
        }

        #battery {
          color: #77cc77;
        }

        #cpu {
          color: #aa11aa;
        }

        #disk {
          color: #ee55ee;
        }

        #memory {
          color: #44aa99;
        }

        #pulseaudio {
          color: #4499ff;
        }

        #workspaces button {
          color: #dddddd;
          padding: 0 2px;
        }

        #workspaces button.focused {
          color: #4499ff;
        }

        #workspaces button:hover {
          background: #222222;
          border: #222222;
          box-shadow: inherit;
          padding: 0 3px;
          text-shadow: inherit;
        }

        #battery,
        #clock,
        #cpu,
        #disk,
        #memory,
        #pulseaudio {
          padding: 0 10px;
        }
      '';
    };
  };
}
