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
  networking.firewall = {
    allowedTCPPorts = [
      25565
      25575
      443
      80
    ];
    allowedUDPPorts = [
      25565
      443
    ];
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "ms0503@outlook.com";
  };
  services = {
    nginx = {
      appendHttpConfig = ''
        proxy_headers_hash_bucket_size 128;
        proxy_headers_hash_max_size 1024;
      '';
      enable = true;
      package = pkgs.nginx.override {
        modules = with pkgs.nginxModules; [
          brotli
          zstd
        ];
        withMail = true;
        withStream = true;
      };
      recommendedBrotliSettings = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      streamConfig = ''
        error_log /var/log/nginx/stream.log info;
        server {
          listen 25565;
          proxy_pass hades.tailc4bea2.ts.net:25565;
          server_name 0.mcsrv.ms0503.dev;
        }
        server {
          listen 25565 udp;
          proxy_pass hades.tailc4bea2.ts.net:25565;
          server_name 0.mcsrv.ms0503.dev;
        }
        server {
          listen 25575;
          proxy_pass hades.tailc4bea2.ts.net:25575;
          server_name 0.mcsrv.ms0503.dev;
        }
      '';
      upstreams.hades.servers."hades.tailc4bea2.ts.net" = { };
      virtualHosts = {
        "mcsrv.ms0503.dev" = {
          enableACME = true;
          forceSSL = true;
          http2 = true;
          http3 = true;
          http3_hq = true;
          kTLS = true;
          locations."/" = {
            extraConfig = ''
              proxy_http_version 1.1;
              proxy_set_header Connection upgrade;
              proxy_set_header Upgrade $http_upgrade;
              proxy_ssl_server_name on;
            '';
            proxyPass = "http://hades";
          };
          quic = true;
          reuseport = true;
        };
      };
    };
    power-profiles-daemon.enable = true;
    tailscale.useRoutingFeatures = "server";
    xremap.enable = false;
  };
  system.stateVersion = "25.11";
  users.users."${username}" = {
    extraGroups = [
      "networkmanager"
      "nginx"
      "wheel"
    ];
    isNormalUser = true;
    shell = pkgs.zsh;
  };
}
