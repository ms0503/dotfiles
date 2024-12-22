{
  inputs,
  pkgs,
  username,
  ...
}:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader.efi.canTouchEfiVariables = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = false;
    prime = {
      amdgpuBusId = "PCI:54:0:0";
      nvidiaBusId = "PCI:1:0:0";
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
      common-gpu-nvidia
      common-hidpi
      common-pc-laptop
      common-pc-ssd
    ]);
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
    power-profiles-daemon.enable = true;
  };
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
