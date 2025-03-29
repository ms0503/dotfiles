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
    printers = {
      ensureDefaultPrinter = "HL-5350DN";
      ensurePrinters = [
        {
          deviceUri = "usb://Brother/HL-5350DN%20series?serial=L2J567505";
          model = "BR5350_2_GPL.ppd";
          name = "HL-5350DN";
          ppdOptions.PageSize = "A4";
        }
      ];
    };
  };
  imports =
    [
      ../../nixos/core
      ../../nixos/gui
      ./hardware-configuration.nix
    ]
    ++ (with inputs.nixos-hardware.nixosModules; [
      asus-battery
      common-cpu-amd
      common-cpu-amd-pstate
      common-cpu-amd-zenpower
      common-gpu-nvidia-nonprime
      common-hidpi
      common-pc-laptop
      common-pc-ssd
    ]);
  networking.firewall.allowedTCPPorts = [
    3000
    80
  ];
  security.pam.services.greetd.enableGnomeKeyring = true;
  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
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
    pipewire.extraConfig.pipewire-pulse."99-tunnel"."pulse.cmd" = [
      {
        args = "module-tunnel-sink server=tcp:mainpc:4713";
        cmd = "load-module";
      }
    ];
    power-profiles-daemon.enable = true;
    printing = {
      drivers = with pkgs; [
        (writeTextDir "share/cups/model/BR5350_2_GPL.ppd" (builtins.readFile ./BR5350_2_GPL.ppd))
        brgenml1cupswrapper
        brgenml1lpr
        brlaser
        cnijfilter2
        gutenprint
        hplip
        postscript-lexmark
        samsung-unified-linux-driver
        splix
      ];
      enable = true;
    };
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x15b7", ATTR{device}=="0x5036", ATTR{power/wakeup}="disabled"
    '';
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
