{
  config,
  inputs,
  pkgs,
  username,
  ...
}:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelParams = [
      "acpi.debug_layer=0xFFFFFFFF"
      "acpi.debug_level=0x2F"
      "acpi_sleep=nonvs"
      "nvidia.NVreg_EnableS0ixPowerManagement=1"
      "usbcore.autosuspend=-1"
    ];
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
      package = config.boot.kernelPackages.nvidiaPackages.beta;
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
#      common-cpu-amd-pstate
      common-cpu-amd-zenpower
      common-gpu-nvidia-nonprime
      common-hidpi
      common-pc-laptop
      common-pc-ssd
    ]);
  powerManagement.resumeCommands = ''
    modprobe -r nvidia-drm
    modprobe -r nvidia-modeset
    modprobe -r nvidia
    sleep 1
    modprobe nvidia
    modprobe nvidia-modeset
    modprobe nvidia-drm
  '';
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
    logind.lidSwitch = "ignore";
    power-profiles-daemon.enable = true;
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x15b7", ATTR{device}=="0x5036", ATTR{power/wakeup}="disabled"
    '';
  };
  system.stateVersion = "24.11";
#  systemd.services.disable-all-wakeup = {
#    description = "disable all wakeup";
#    script = ''
#      targets=(
#        $(cat /proc/acpi/wakeup | grep enabled | cut -f1)
#      )
#      for target in "''${targets[@]}"; do
#        echo "$target" > /proc/acpi/wakeup
#      done
#    '';
#    wantedBy = [
#      "multi-user.target"
#    ];
#  };
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
