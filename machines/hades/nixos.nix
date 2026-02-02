{
  inputs,
  lib,
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
  };
  environment.systemPackages = [ ];
  hardware.nvidia = {
    powerManagement.enable = lib.mkForce true;
    prime = {
      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };
  imports = [
    ./hardware-configuration.nix
  ]
  ++ (with inputs.nixos-hardware.nixosModules; [
    common-cpu-intel
    common-gpu-nvidia
    common-hidpi
    common-pc
    common-pc-ssd
  ]);
  networking.firewall.allowedTCPPorts = [
    80
  ];
  services = {
    power-profiles-daemon.enable = true;
    tailscale.useRoutingFeatures = "server";
    xremap.enable = false;
  };
  system.stateVersion = "24.11";
  users.users."${username}" = {
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    isNormalUser = true;
    shell = pkgs.zsh;
  };
}
