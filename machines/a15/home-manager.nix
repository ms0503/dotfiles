{ pkgs, ... }:
let
  rosCodename = "humble";
in
{
  home.packages = with pkgs; [
    colcon
    (
      with rosPackages.${rosCodename};
      buildEnv {
        paths = [
          ros-core
        ];
      }
    )
  ];
  imports = [
    ../../home-manager/cli
    ../../home-manager/desktop/hyprland
    ../../home-manager/gui
  ];
  wayland.windowManager.hyprland.settings = {
    input.kb_layout = "jp";
    monitor = [
      "desc:Chimei Innolux Corporation 0x1521, 1920x1080@144, 0x0, 1"
    ];
    workspace = [
      "1,monitor:DP-1"
      "2,monitor:DP-1"
      "3,monitor:DP-1"
      "4,monitor:DP-1"
      "6,monitor:DP-1"
      "6,monitor:DP-1"
      "7,monitor:DP-1"
      "8,monitor:DP-1"
      "9,monitor:DP-1"
      "10,monitor:DP-1"
    ];
  };
}
# vim: et sts=2 sw=2 ts=2
