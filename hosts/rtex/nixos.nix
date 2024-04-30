{config, inputs, pkgs, username, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
  console.keyMap = "jp106";
  hardware = {
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      enable = true;
    };
  };
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
    common-cpu-intel
    common-gpu-nvidia
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
	  x = 3840;
	  y = 2400;
	}
      ];
      videoDrivers = [
        "nvidia"
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
