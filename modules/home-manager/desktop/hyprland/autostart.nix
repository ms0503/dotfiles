{
  config,
  lib,
  pkgs,
  theme,
  ...
}:
let
  inherit (config.ms0503) terminal;
  inherit (lib) mkIf mkLuaInline;
  inherit (pkgs) writeScriptBin;
  inherit (theme) colors;
  cfg = config.ms0503.desktop.hyprland;
  cfgGui = config.ms0503.gui;
  sleep = writeScriptBin "sleep" ''
    swayidle -w \
      before-sleep 'swaylock -f -c ${colors.bg}' \
      &
  '';
  waybar-wrapper = writeScriptBin "waybar-wrapper" ''
    while :; do
      waybar
      sleep 5
    done
  '';
in
{
  config = mkIf (cfgGui.enable && cfg.enable) {
    wayland.windowManager.hyprland.settings = {
      on._args = [
        "hyprland.start"
        (mkLuaInline ''
          function()
            hl.exec_cmd('uwsm app -- dbus-update-activation-environment --systemd --all')
            hl.exec_cmd('uwsm app -- systemctl --user start hyprland-session.target')
            hl.exec_cmd('uwsm app -- libinput-gestures')
            hl.exec_cmd('uwsm app -- ${sleep}/bin/sleep')
            hl.exec_cmd('uwsm app -- blueman-applet')
            hl.exec_cmd('uwsm app -- nm-applet')
            hl.exec_cmd('uwsm app -- ${waybar-wrapper}/bin/waybar-wrapper')
            hl.exec_cmd('uwsm app -- awww-daemon')
            hl.exec_cmd('uwsm app -- awww img ~/.config/hypr/wallpaper/bg.webp')
            hl.exec_cmd('uwsm app -- fcitx5 -D')
            hl.exec_cmd('uwsm app -- steam -silent')
            hl.exec_cmd('uwsm app -- microsoft-edge-dev', {
              workspace = '${cfg.startup-monitor * 10 + 1 |> builtins.toString} silent'
            })
            hl.exec_cmd('uwsm app -- ${terminal}', {
              workspace = '${cfg.startup-monitor * 10 + 2 |> builtins.toString} silent'
            })
            hl.exec_cmd('uwsm app -- discordcanary', {
              workspace = '${cfg.startup-monitor * 10 + 3 |> builtins.toString} silent'
            })
          end
        '')
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
