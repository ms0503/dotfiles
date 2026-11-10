{ myLib, ... }:
{
  ms0503 = {
    arch = "x86_64";
    bluetooth.enable = true;
    bootloader = {
      efi.enable = true;
      type = "lanzaboote";
    };
    desktop = {
      common = {
        greeter = "tuigreet";
        wayland = {
          enable = true;
          shell = "noctalia";
        };
      };
      hyprland.enable = true;
    };
    feature-set = myLib.const.feature-sets.full;
    gpu = "nvidia";
    gui.enable = true;
    im = {
      enable = true;
      type = "mozkey";
    };
    media.enable = true;
    rust.extraTools = [ ];
    server = {
      minecraft.enable = false;
      nix-repo-updater.enable = false;
    };
    shell.type = "zsh";
    sound.streaming = {
      receiver = {
        enable = true;
        output-sink = "alsa_output.pci-0000_2d_00.4.analog-stereo";
      };
      sender.enable = false;
    };
    steam.enable = true;
  };
}
