{config, hostname, ...}: {
  networking = {
    firewall = {
      allowedUDPPorts = [
        config.services.tailscale.port
      ];
      enable = true;
      trustedInterfaces = [
        "tailscale0"
      ];
    };
    hostName = hostname;
    networkmanager.enable = true;
  };
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };
  systemd.services.NetworkManager-wait-online.enable = false;
}
