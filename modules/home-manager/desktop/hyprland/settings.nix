{
  config,
  lib,
  theme,
  ...
}:
let
  inherit (lib) mergeAttrsList mkDefault mkIf;
  inherit (theme) colors;
  cfg = config.ms0503.desktop.hyprland;
  cfgGui = config.ms0503.gui;
  force-opaque-windows = [
    {
      match.class = ".*\\.x86_64";
    }
    {
      match.class = "Minecraft.*";
    }
    {
      match.class = "Unity";
    }
    {
      match.class = "VampireSurvivors\\.exe";
    }
    {
      match.class = "VirtualBox Machine";
    }
    {
      match.class = "[Bb]lender";
    }
    {
      match.class = "gimp";
    }
    {
      match.class = "hoi4";
    }
    {
      match.class = "msedge-_cmkncekebbebpfilplodngbpllndjkfo-Default"; # Chrome Remote Desktop
    }
    {
      match.class = "steam_app_[0-9]+";
    }
    {
      match.content = "game";
    }
    {
      match.content = "photo";
    }
    {
      match.content = "video";
    }
    {
      match.title = ".*YouTube.*";
    }
    {
      match.title = ".*\\.avif \\([0-9]+×[0-9]+\\).*";
    }
    {
      match.title = ".*\\.bmp \\([0-9]+×[0-9]+\\).*";
    }
    {
      match.title = ".*\\.gif \\([0-9]+×[0-9]+\\).*";
    }
    {
      match.title = ".*\\.jpe?g \\([0-9]+×[0-9]+\\).*";
    }
    {
      match.title = ".*\\.png \\([0-9]+×[0-9]+\\).*";
    }
    {
      match.title = ".*\\.webp \\([0-9]+×[0-9]+\\).*";
    }
    {
      match.title = ".*ニコニコ動画.*";
    }
  ];
  opaque-window-rules =
    force-opaque-windows
    |> builtins.map (
      win:
      mergeAttrsList [
        win
        {
          opaque = true;
        }
      ]
    );
in
{
  config = mkIf (cfgGui.enable && cfg.enable) {
    wayland.windowManager.hyprland.settings = {
      animation = [
        {
          bezier = "default";
          enabled = true;
          leaf = "border";
          speed = 5;
        }
        {
          bezier = "default";
          enabled = true;
          leaf = "fade";
          speed = 5;
        }
        {
          bezier = "myBezier";
          enabled = true;
          leaf = "layers";
          speed = 4;
          style = "fade";
        }
        {
          bezier = "myBezier";
          enabled = true;
          leaf = "windows";
          speed = 4;
          style = "slide";
        }
        {
          bezier = "default";
          enabled = true;
          leaf = "workspaces";
          speed = 6;
        }
      ];
      config = {
        decoration = {
          active_opacity = 0.9;
          blur.enabled = false;
          fullscreen_opacity = 0.9;
          inactive_opacity = 0.95;
          rounding = 10;
        };
        dwindle.preserve_split = true;
        ecosystem = {
          no_donation_nag = true;
          no_update_news = true;
        };
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
            scroll_factor = mkDefault 0.1;
          };
        };
        master.new_status = "slave";
        misc.disable_hyprland_logo = true;
        xwayland.force_zero_scaling = true;
      };
      curve = [
        {
          _args = [
            "myBezier"
            {
              points = [
                [
                  0.05
                  0.9
                ]
                [
                  0.1
                  1.05
                ]
              ];
              type = "bezier";
            }
          ];
        }
      ];
      window_rule = [
        {
          float = true;
          match = {
            class = "^$";
            title = "^$";
          };
          no_focus = true;
        }
        {
          match.class = "fcitx";
          pseudo = true;
        }
        {
          float = true;
          match = {
            class = "jetbrains-.*";
            title = "win[0-9]+";
          };
          no_focus = true;
        }
        {
          float = true;
          match = {
            class = "kicad";
            title = ".* — フットプリント エディター";
          };
        }
        {
          float = true;
          match = {
            class = "kicad";
            title = "シンボル選択.*";
          };
        }
        {
          float = true;
          match = {
            class = "kicad";
            title = "フットプリントを割り当て";
          };
        }
        {
          float = true;
          match = {
            class = "kicad";
            title = ".* — シンボル エディター";
          };
        }
      ]
      ++ opaque-window-rules;
    };
  };
}
