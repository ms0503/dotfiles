{
  inputs,
  pkgs,
  username,
  ...
}:
{
  boot = {
    kernel.sysctl = {
      "net.ipv4.ip_forward" = true;
      "net.ipv6.conf.all.forwarding" = true;
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader.efi.canTouchEfiVariables = true;
    resumeDevice = "/dev/disk/by-uuid/ae27955d-245c-465d-ad7a-1e24a2a310f0";
  };
  environment.systemPackages = [ ];
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
    4713
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
    pipewire.extraConfig.pipewire-pulse."99-listen"."pulse.cmd" = [
      {
        args = "module-native-protocol-tcp auth-anonymous=1 listen=0.0.0.0";
        cmd = "load-module";
      }
    ];
    power-profiles-daemon.enable = true;
    tailscale.useRoutingFeatures = "server";
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
