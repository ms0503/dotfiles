{
  config,
  pkgs,
  theme,
  ...
}:
let
  inherit (theme) colors;
in
{
  home = {
    file."${config.xdg.configHome}/swaylock/config".text = with colors; ''
      bs-hl-color=${cyan}
      clock
      datestr=%a, %b %d
      effect-blur=5x5
      font-size=52
      font=Noto Sans CJK JP
      ignore-empty-password
      indicator-idle-visible
      indicator-radius=150
      indicator-thickness=15
      inside-clear-color=00000000
      inside-color=00000000
      inside-ver-color=00000000
      inside-wrong-color=00000000
      key-hl-color=${white}
      layout-bg-color=00000000
      layout-border-color=00000000
      layout-text-color=${fg}
      line-clear-color=00000000
      line-color=00000000
      line-ver-color=00000000
      line-wrong-color=00000000
      ring-clear-color=${cyan}
      ring-color=${fg}
      ring-ver-color=${white}
      ring-wrong-color=${red}
      separator-color=00000000
      text-clear-color=${cyan}
      text-color=${fg}
      text-ver-color=${fg}
      text-wrong-color=${red}
      timestr=%H:%M:%S
    '';
    packages = with pkgs; [
      swaylock
    ];
  };
  systemd.user.services.lock-on-suspend = {
    Install.WantedBy = [
      "sleep.target"
    ];
    Service = {
      ExecStart = "swaylock -f -c ${colors.bg}";
      Type = "oneshot";
    };
    Unit = {
      Before = "sleep.target";
      Description = "lock on suspend";
    };
  };
}
