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
    resumeDevice = "/dev/disk/by-uuid/0a943e07-390e-4810-a528-d1845c862246";
  };
  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
  ];
  hardware.printers = {
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
  imports = [
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
          ${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland
        '';
        user = username;
      };
    };
    hardware.openrgb.enable = true;
    logind.settings.Login.HandleLidSwitch = "ignore";
    pipewire = {
      extraConfig.pipewire-pulse."99-tunnel"."pulse.cmd" = [
        {
          args = "module-tunnel-sink server=tcp:nyx:4713";
          cmd = "load-module";
        }
      ];
      wireplumber.extraConfig."99-sink-priority"."monitor.alsa.rules" = [
        {
          actions.update-props = {
            "priority.driver" = 1100;
            "priority.session" = 1100;
          };
          matches = [
            {
              "node.name" = "tunnel-sink.tcp:nyx:4713";
            }
          ];
        }
        {
          actions.update-props = {
            "priority.driver" = 1200;
            "priority.session" = 1200;
          };
          matches = [
            {
              "node.name" = "ALVR Audio";
            }
          ];
        }
      ];
    };
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
    tailscale.useRoutingFeatures = "client";
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="acpi", DRIVER=="battery", ATTR{power/wakeup}="disabled"
      ACTION=="add", SUBSYSTEM=="acpi", DRIVER=="button", ATTR{power/wakeup}="disabled"
      ACTION=="add", SUBSYSTEM=="i2c", DRIVER=="i2c_hid_acpi", ATTR{power/wakeup}="disabled"
      ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
      ACTION=="add", SUBSYSTEM=="pci", DRIVER=="xhci_hcd", ATTR{power/wakeup}="disabled"
    '';
    xserver.xkb = {
      layout = "jp";
      model = "pc105";
      options = "caps:none";
      variant = "OADG109A";
    };
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
