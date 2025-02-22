{ pkgs, ... }:
{
  home = {
    packages = [ ];
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

    Host a15
      HostName 192.168.68.62
      IdentityFile ~/.ssh/a15
      User ms0503
  '';
  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "jp";
      kb_model = "pc105";
      kb_options = "caps:none";
      kb_variant = "OADG109A";
    };
    monitor = [
      "desc:Hewlett Packard HP ZR2440w CN42260H0R, 1920x1200@60, 1920x-120, 1"
      "desc:I-O Data Device Inc LCD-MF224ED GGF504807255, 1920x1080@60, 0x0, 1"
    ];
    workspace = [
      "1,monitor:desc:Hewlett Packard HP ZR2440w CN42260H0R"
      "2,monitor:desc:Hewlett Packard HP ZR2440w CN42260H0R"
      "3,monitor:desc:Hewlett Packard HP ZR2440w CN42260H0R"
      "4,monitor:desc:Hewlett Packard HP ZR2440w CN42260H0R"
      "5,monitor:desc:Hewlett Packard HP ZR2440w CN42260H0R"
      "6,monitor:desc:Hewlett Packard HP ZR2440w CN42260H0R"
      "7,monitor:desc:Hewlett Packard HP ZR2440w CN42260H0R"
      "8,monitor:desc:Hewlett Packard HP ZR2440w CN42260H0R"
      "9,monitor:desc:Hewlett Packard HP ZR2440w CN42260H0R"
      "10,monitor:desc:Hewlett Packard HP ZR2440w CN42260H0R"
      "11,monitor:desc:I-O Data Device Inc LCD-MF224ED GGF504807255"
      "12,monitor:desc:I-O Data Device Inc LCD-MF224ED GGF504807255"
      "13,monitor:desc:I-O Data Device Inc LCD-MF224ED GGF504807255"
      "14,monitor:desc:I-O Data Device Inc LCD-MF224ED GGF504807255"
      "15,monitor:desc:I-O Data Device Inc LCD-MF224ED GGF504807255"
      "16,monitor:desc:I-O Data Device Inc LCD-MF224ED GGF504807255"
      "17,monitor:desc:I-O Data Device Inc LCD-MF224ED GGF504807255"
      "18,monitor:desc:I-O Data Device Inc LCD-MF224ED GGF504807255"
      "19,monitor:desc:I-O Data Device Inc LCD-MF224ED GGF504807255"
      "20,monitor:desc:I-O Data Device Inc LCD-MF224ED GGF504807255"
    ];
  };
}
