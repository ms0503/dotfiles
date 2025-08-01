{ myPkgs, pkgs, ... }:
{
  home = {
    packages =
      (with pkgs; [
        gcc-arm-embedded
        openocd
        stm32cubemx
      ])
      ++ (with myPkgs; [
        platformio-core
      ]);
    pointerCursor = {
      gtk.enable = true;
      name = "Milk1";
      package = pkgs.milk-cursor-themes;
      size = 32;
      x11.enable = true;
    };
    sessionVariables = {
      HYPRCURSOR_SIZE = "32";
      HYPRCURSOR_THEME = "Milk1";
    };
  };
  imports = [
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

    Host lightrover
      HostName 192.168.0.140
      IdentityFile ~/.ssh/lightrover
      User pi

    Host nyx
      HostName nyx
      IdentityFile ~/.ssh/nyx
      User ms0503
  '';
  wayland.windowManager.hyprland.settings = {
    device = [
      {
        enabled = false;
        name = "Lid Switch";
      }
    ];
    exec-once = [
      "openrgb --startminimized"
    ];
    input = {
      kb_layout = "jp";
      kb_model = "pc105";
      kb_options = "caps:none";
      kb_variant = "OADG109A";
    };
    monitor = [
      "desc:Chimei Innolux Corporation 0x1521, 1920x1080@144, 0x0, 1"
    ];
    workspace = [
      "1, default:true, monitor:desc:Chimei Innolux Corporation 0x1521"
      "2, monitor:desc:Chimei Innolux Corporation 0x1521"
      "3, monitor:desc:Chimei Innolux Corporation 0x1521"
      "4, monitor:desc:Chimei Innolux Corporation 0x1521"
      "5, monitor:desc:Chimei Innolux Corporation 0x1521"
      "6, monitor:desc:Chimei Innolux Corporation 0x1521"
      "7, monitor:desc:Chimei Innolux Corporation 0x1521"
      "8, monitor:desc:Chimei Innolux Corporation 0x1521"
      "9, monitor:desc:Chimei Innolux Corporation 0x1521"
      "10, monitor:desc:Chimei Innolux Corporation 0x1521"
    ];
  };
}
