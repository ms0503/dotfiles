{ config, lib, ... }:
let
  inherit (config.ms0503) terminalCmd;
  inherit (lib) mkIf mkLuaInline;
  cfg = config.ms0503.desktop.hyprland;
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      on = [
        {
          _args = [
            "hyprland.start"
            (mkLuaInline ''
              function()
                hl.exec_cmd('uwsm app -- dbus-update-activation-environment --systemd --all')
                hl.exec_cmd('uwsm app -- systemctl --user start hyprland-session.target')
                hl.exec_cmd('uwsm app -- microsoft-edge-dev', {
                  workspace = '${cfg.startup-monitor * 10 + 1 |> builtins.toString} silent'
                })
                hl.exec_cmd('uwsm app -- ${terminalCmd}', {
                  workspace = '${cfg.startup-monitor * 10 + 2 |> builtins.toString} silent'
                })
                hl.exec_cmd('uwsm app -- discordcanary', {
                  workspace = '${cfg.startup-monitor * 10 + 3 |> builtins.toString} silent'
                })
              end
            '')
          ];
        }
        {
          _args = [
            "hyprland.shutdown"
            (mkLuaInline ''
              function()
                os.execute('systemctl --user stop hyprland-session.target && sleep 0.1')
              end
            '')
          ];
        }
      ];
      window_rule = [
        {
          match.class = "discord";
          workspace = "${cfg.startup-monitor * 10 + 3 |> builtins.toString} silent";
        }
      ];
    };
  };
}
