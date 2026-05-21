{
  lib,
  myPkgs,
  pkgs,
  username,
  ...
}:
let
  inherit (lib) mkLuaInline;
in
{
  home = {
    packages = with myPkgs; [
      (fakevrchat.override rec {
        compat-client-install-path = "/home/${username}/.local/share/Steam";
        compat-data-path = "${compat-client-install-path}/steamapps/compatdata/438100";
        proton-path = "${proton-ge-rtsp-bin.steamcompattool}/proton";
        vrchat-exe-path = "${compat-client-install-path}/steamapps/common/VRChat/VRChat.exe";
      })
    ];
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
  imports = [ ];
  programs.ssh.matchBlocks = {
    ares = {
      hostname = "ares";
      identityFile = "~/.ssh/ares";
      user = "ms0503";
    };
    erebos = {
      hostname = "erebos";
      identityFile = "~/.ssh/erebos";
      user = "ms0503";
    };
    hades = {
      hostname = "hades";
      identityFile = "~/.ssh/hades";
      user = "ms0503";
    };
    hades-minecraft = {
      hostname = "hades";
      identityFile = "~/.ssh/hades-minecraft";
      user = "minecraft";
    };
    github = {
      hostname = "github.com";
      identityFile = "~/.ssh/github";
      user = "git";
    };
  };
  wayland.windowManager.hyprland.settings = {
    config.input = {
      kb_layout = "jp";
      kb_model = "pc105";
      kb_options = "caps:none,compose:paus";
      kb_variant = "OADG109A";
    };
    monitor = [
      {
        mode = "1920x1200@60";
        output = "desc:Hewlett Packard HP ZR2440w CN42260H0R";
        position = "1920x-120";
        scale = 1;
      }
      {
        mode = "1920x1080@60";
        output = "I-O Data Device Inc LCD-MF224ED GGF504807255";
        position = "0x0";
        scale = 1;
      }
    ];
    workspace_rule = [
      {
        default = true;
        monitor = "desc:Hewlett Packard HP ZR2440w CN42260H0R";
        workspace = "1";
      }
      {
        monitor = "desc:Hewlett Packard HP ZR2440w CN42260H0R";
        workspace = "2";
      }
      {
        monitor = "desc:Hewlett Packard HP ZR2440w CN42260H0R";
        workspace = "3";
      }
      {
        monitor = "desc:Hewlett Packard HP ZR2440w CN42260H0R";
        workspace = "4";
      }
      {
        monitor = "desc:Hewlett Packard HP ZR2440w CN42260H0R";
        workspace = "5";
      }
      {
        monitor = "desc:Hewlett Packard HP ZR2440w CN42260H0R";
        workspace = "6";
      }
      {
        monitor = "desc:Hewlett Packard HP ZR2440w CN42260H0R";
        workspace = "7";
      }
      {
        monitor = "desc:Hewlett Packard HP ZR2440w CN42260H0R";
        workspace = "8";
      }
      {
        monitor = "desc:Hewlett Packard HP ZR2440w CN42260H0R";
        workspace = "9";
      }
      {
        monitor = "desc:Hewlett Packard HP ZR2440w CN42260H0R";
        workspace = "10";
      }
      {
        default = true;
        monitor = "desc:I-O Data Device Inc LCD-MF224ED GGF504807255";
        workspace = "11";
      }
      {
        monitor = "desc:I-O Data Device Inc LCD-MF224ED GGF504807255";
        workspace = "12";
      }
      {
        monitor = "desc:I-O Data Device Inc LCD-MF224ED GGF504807255";
        workspace = "13";
      }
      {
        monitor = "desc:I-O Data Device Inc LCD-MF224ED GGF504807255";
        workspace = "14";
      }
      {
        monitor = "desc:I-O Data Device Inc LCD-MF224ED GGF504807255";
        workspace = "15";
      }
      {
        monitor = "desc:I-O Data Device Inc LCD-MF224ED GGF504807255";
        workspace = "16";
      }
      {
        monitor = "desc:I-O Data Device Inc LCD-MF224ED GGF504807255";
        workspace = "17";
      }
      {
        monitor = "desc:I-O Data Device Inc LCD-MF224ED GGF504807255";
        workspace = "18";
      }
      {
        monitor = "desc:I-O Data Device Inc LCD-MF224ED GGF504807255";
        workspace = "19";
      }
      {
        monitor = "desc:I-O Data Device Inc LCD-MF224ED GGF504807255";
        workspace = "20";
      }
    ];
  };
}
