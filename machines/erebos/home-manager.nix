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
    packages = builtins.concatLists [
      (with pkgs; [
        gcc-arm-embedded
        openocd
        platformio-core
        stm32cubemx
      ])
      (with myPkgs; [
        (fakevrchat.override rec {
          compat-client-install-path = "/home/${username}/.local/share/Steam";
          compat-data-path = "${compat-client-install-path}/steamapps/compatdata/438100";
          proton-path = "${proton-ge-rtsp-bin.steamcompattool}/proton";
          vrchat-exe-path = "${compat-client-install-path}/steamapps/common/VRChat/VRChat.exe";
        })
      ])
    ];
    pointerCursor = {
      enable = true;
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
  programs.ssh.settings = {
    ares = {
      HostName = "ares";
      IdentityFile = "~/.ssh/ares";
      User = "ms0503";
    };
    github = {
      HostName = "github.com";
      IdentityFile = "~/.ssh/github";
      User = "git";
    };
    hades = {
      HostName = "hades";
      IdentityFile = "~/.ssh/hades";
      User = "ms0503";
    };
    hades-minecraft = {
      HostName = "hades";
      IdentityFile = "~/.ssh/hades-minecraft";
      User = "minecraft";
    };
    nyx = {
      HostName = "nyx";
      IdentityFile = "~/.ssh/nyx";
      User = "ms0503";
    };
  };
  wayland.windowManager.hyprland.settings = {
    config.input = {
      kb_layout = "jp";
      kb_model = "pc105";
      kb_options = "caps:none,compose:paus";
      kb_variant = "OADG109A";
    };
    device = [
      {
        enabled = false;
        name = "Lid Switch";
      }
      {
        accel_profile = "flat";
        name = "elecom-opticalmouse";
        sensitivity = -0.2;
      }
    ];
    monitor = {
      mode = "1920x1080@144";
      output = "desc:Chimei Innolux Corporation 0x1521";
      position = "0x0";
      scale = 1;
    };
    on = [
      {
        _args = [
          "hyprland.start"
          (mkLuaInline ''
            function()
              hl.exec_cmd("uwsm app -- openrgb --startminimized")
            end
          '')
        ];
      }
    ];
    workspace_rule = [
      {
        default = true;
        monitor = "desc:Chimei Innolux Corporation 0x1521";
        workspace = "1";
      }
      {
        monitor = "desc:Chimei Innolux Corporation 0x1521";
        workspace = "2";
      }
      {
        monitor = "desc:Chimei Innolux Corporation 0x1521";
        workspace = "3";
      }
      {
        monitor = "desc:Chimei Innolux Corporation 0x1521";
        workspace = "4";
      }
      {
        monitor = "desc:Chimei Innolux Corporation 0x1521";
        workspace = "5";
      }
      {
        monitor = "desc:Chimei Innolux Corporation 0x1521";
        workspace = "6";
      }
      {
        monitor = "desc:Chimei Innolux Corporation 0x1521";
        workspace = "7";
      }
      {
        monitor = "desc:Chimei Innolux Corporation 0x1521";
        workspace = "8";
      }
      {
        monitor = "desc:Chimei Innolux Corporation 0x1521";
        workspace = "9";
      }
      {
        monitor = "desc:Chimei Innolux Corporation 0x1521";
        workspace = "10";
      }
    ];
  };
}
