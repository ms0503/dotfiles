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
  programs.ssh.extraConfig = ''
    Host aur aur.archlinux.org
      HostName aur.archlinux.org
      IdentityFile ~/.ssh/aur
      User aur

    Host github github.com
      HostName github.com
      IdentityFile ~/.ssh/github
      User git

    Host mainpc
      HostName 192.168.68.55
      IdentityFile ~/.ssh/mainpc
      User ms0503
  '';
  wayland.windowManager.hyprland.settings = {
    input.kb_layout = "jp";
    monitor = [
      "desc:Chimei Innolux Corporation 0x1521, 1920x1080@144, 0x0, 1"
    ];
    workspace = [
      "1,monitor:desc:Chimei Innolux Corporation 0x1521"
      "2,monitor:desc:Chimei Innolux Corporation 0x1521"
      "3,monitor:desc:Chimei Innolux Corporation 0x1521"
      "4,monitor:desc:Chimei Innolux Corporation 0x1521"
      "6,monitor:desc:Chimei Innolux Corporation 0x1521"
      "6,monitor:desc:Chimei Innolux Corporation 0x1521"
      "7,monitor:desc:Chimei Innolux Corporation 0x1521"
      "8,monitor:desc:Chimei Innolux Corporation 0x1521"
      "9,monitor:desc:Chimei Innolux Corporation 0x1521"
      "10,monitor:desc:Chimei Innolux Corporation 0x1521"
    ];
  };
}
# vim: et sts=2 sw=2 ts=2
