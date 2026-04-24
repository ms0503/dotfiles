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
    loader.grub.device = "/dev/vda";
  };
  environment.systemPackages = [ ];
  imports = [
    ./hardware-configuration.nix
  ]
  ++ (with inputs.nixos-hardware.nixosModules; [
    common-cpu-intel-cpu-only
    common-pc
    common-pc-ssd
  ]);
  networking.firewall.allowedTCPPorts = [
    25565
    80
  ];
  services = {
    power-profiles-daemon.enable = true;
    tailscale.useRoutingFeatures = "server";
    xremap.enable = false;
  };
  system.stateVersion = "25.11";
  users.users."${username}" = {
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    isNormalUser = true;
    shell = pkgs.zsh;
  };
}
