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
    Host a15
      HostName a15
      IdentityFile ~/.ssh/a15
      User ms0503

    Host aur aur.archlinux.org
      HostName aur.archlinux.org
      IdentityFile ~/.ssh/aur
      User aur

    Host github github.com
      HostName github.com
      IdentityFile ~/.ssh/github
      User git
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
      "r[1-10],monitor:desc:I-O Data Device Inc LCD-MF224ED GGF504807255"
      "r[11-20],monitor:desc:Hewlett Packard HP ZR2440w CN42260H0R"
    ];
  };
}
