{ myLib, pkgs, ... }:
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
    rust.extraTools = with pkgs.fenix; [
      targets.thumbv7em-none-eabihf.latest.rust-std
      targets.thumbv7em-none-eabihf.stable.rust-std
    ];
    server = {
      minecraft.enable = false;
      nix-repo-updater.enable = false;
    };
    shell.type = "zsh";
    sound.streaming = {
      receiver.enable = false;
      sender = {
        destination = {
          name = "nyx";
          port = 5004;
        };
        enable = true;
        input-sink = {
          fl = "alsa_output.pci-0000_05_00.6.analog-stereo:monitor_FL";
          fr = "alsa_output.pci-0000_05_00.6.analog-stereo:monitor_FR";
        };
      };
    };
    steam.enable = true;
  };
}
