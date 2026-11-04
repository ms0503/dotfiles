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
  imports = builtins.concatLists [
    [
      ./hardware-configuration.nix
    ]
    (with inputs.nixos-hardware.nixosModules; [
      common-cpu-amd
      common-cpu-amd-pstate
      common-cpu-amd-zenpower
      common-gpu-nvidia-nonprime
      common-hidpi
      common-pc
      common-pc-ssd
    ])
  ];
  networking.firewall = {
    allowedTCPPorts = [
      3000
      80
    ];
    allowedUDPPorts = [
      5004
    ];
  };
  services = {
    pipewire.extraConfig.pipewire."99-rtp-receiver"."context.modules" = [
      {
        args = {
          "audio.channels" = 2;
          "audio.format" = "F32LE";
          "audio.rate" = 48000;
          "sess.media" = "opus";
          "source.ip" = "0.0.0.0";
          "source.port" = 5004;
          "stream.props" = {
            "node.name" = "rtp-receiver";
            "target.object" = "alsa_output.pci-0000_2d_00.4.analog-stereo";
          };
        };
        name = "libpipewire-module-rtp-source";
      }
    ];
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
    shell = pkgs.zsh;
  };
}
