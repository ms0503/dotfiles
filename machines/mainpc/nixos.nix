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
      "nvidia.NVreg_EnableS0ixPowerManagement=1"
    ];
    loader.efi.canTouchEfiVariables = true;
    resumeDevice = "/dev/disk/by-uuid/ae27955d-245c-465d-ad7a-1e24a2a310f0";
  };
  environment.systemPackages = [ ];
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        ocl-icd
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
      ./hardware-configuration.nix
    ]
    ++ (with inputs.nixos-hardware.nixosModules; [
      common-cpu-amd
      common-cpu-amd-pstate
      common-cpu-amd-zenpower
      common-gpu-nvidia-nonprime
      common-hidpi
      common-pc
      common-pc-ssd
    ]);
  networking.firewall.allowedTCPPorts = [
    3000
    80
  ];
  security.pam.services.greetd.enableGnomeKeyring = true;
  services = {
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
      "dialout"
      "networkmanager"
      "video"
      "wheel"
    ];
    isNormalUser = true;
    shell = pkgs.bash;
  };
}
