{inputs, pkgs, username, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
  console.keyMap = "jp106";
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/desktop
    ../../modules/programs/flatpak.nix
    ../../modules/programs/gpg.nix
    ../../modules/programs/media.nix
    ../../modules/programs/nix-ld.nix
    ../../modules/programs/secureboot.nix
    ../../modules/programs/shell.nix
    ../../modules/programs/steam.nix
    ../../modules/programs/xserver.nix
  ] ++ (with inputs.nixos-hardware.nixosModules; [
    common-cpu-amd
    common-pc-ssd
  ]);
  services = {
    udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
    ];
    xserver = {
      excludePackages = with pkgs; [
        xterm
      ];
      resolutions = [
        {
          x = 1920;
          y = 1200;
        }
      ];
      xkb = {
        layout = "jp";
        model = "pc105";
        variant = "OADG109A";
      };
    };
  };
  system.stateVersion = "23.11";
  users.users."${username}" = {
    extraGroups = [
      "audio"
      "networkmanager"
      "video"
      "wheel"
    ];
    isNormalUser = true;
    shell = pkgs.bash;
  };
}
