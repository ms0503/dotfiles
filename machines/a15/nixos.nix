{
  inputs,
  pkgs,
  username,
  ...
}:
{
  boot = {
    extraModprobeConfig = ''
      options nvidia NVreg_PreserveVideoMemoryAllocations=1 NVreg_TemporaryFilePath=/var/tmp
    '';
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader.efi.canTouchEfiVariables = true;
    resumeDevice = "/dev/disk/by-uuid/0a943e07-390e-4810-a528-d1845c862246";
  };
  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
  ];
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        vaapiVdpau
      ];
    };
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      powerManagement.enable = false;
    };
  };
  imports =
    [
      ../../nixos/core
      ../../nixos/gui
      ../../nixos/programs/bt.nix
      ../../nixos/programs/hyprland.nix
      ../../nixos/programs/media.nix
      ../../nixos/programs/nh.nix
      ../../nixos/programs/nix-ld.nix
      ../../nixos/programs/secureboot.nix
      ../../nixos/programs/shell.nix
      ../../nixos/programs/steam.nix
      ./hardware-configuration.nix
    ]
    ++ (with inputs.nixos-hardware.nixosModules; [
      asus-battery
      common-cpu-amd
      common-cpu-amd-pstate
      common-cpu-amd-raphael-igpu
      common-cpu-amd-zenpower
      common-gpu-nvidia-nonprime
      common-hidpi
      common-pc-laptop
      common-pc-ssd
    ]);
  security.pam.services.greetd.enableGnomeKeyring = true;
  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
    greetd = {
      enable = true;
      settings.default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland
        '';
        user = username;
      };
    };
    hardware.openrgb.enable = true;
    power-profiles-daemon.enable = true;
  };
  swapDevices = [
    {
      device = "/dev/disk/by-uuid/0a943e07-390e-4810-a528-d1845c862246";
    }
  ];
  system.stateVersion = "24.11";
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
# vim: et sts=2 sw=2 ts=2
