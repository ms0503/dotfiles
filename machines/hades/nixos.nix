{
  inputs,
  lib,
  pkgs,
  username,
  ...
}:
let
  inherit (lib) mkForce;
in
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
    powerManagement.enable = mkForce true;
    prime = {
      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };
  imports = builtins.concatLists [
    [
      ./hardware-configuration.nix
    ]
    (with inputs.nixos-hardware.nixosModules; [
      common-cpu-intel
      common-gpu-nvidia
      common-hidpi
      common-pc
      common-pc-ssd
    ])
    [
      ./server-mcsrv.nix
    ]
  ];
  networking.firewall.allowedTCPPorts = [
    80
  ];
  services = {
    nginx = {
      enable = true;
      package = pkgs.nginxMainline.override {
        modules = with pkgs.nginxModules; [
          brotli
          zstd
        ];
        withMail = true;
      };
      recommendedBrotliSettings = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
    };
    tailscale.useRoutingFeatures = "server";
    xremap.enable = false;
  };
  system.stateVersion = "24.11";
  users.users = {
    "${username}" = {
      extraGroups = [
        "minecraft"
        "networkmanager"
        "nginx"
        "wheel"
      ];
      isNormalUser = true;
      shell = pkgs.zsh;
    };
    minecraft.shell = pkgs.bash;
  };
}
