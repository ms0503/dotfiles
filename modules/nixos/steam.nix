{
  config,
  lib,
  myPkgs,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.steam;
in
{
  config = mkIf cfg.enable {
    boot.kernelPatches = [
      {
        name = "amdgpu-ignore-ctx-privileges";
        patch = pkgs.fetchpatch {
          hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
          name = "cap_sys_nice_begone.patch";
          url = "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
        };
      }
    ];
    environment.systemPackages = with pkgs; [
      wlx-overlay-s
    ];
    hardware.steam-hardware.enable = true;
    programs = {
      alvr = {
        enable = true;
        openFirewall = true;
      };
      steam = {
        dedicatedServer.openFirewall = true;
        enable = true;
        extraCompatPackages =
          (with pkgs; [
            proton-ge-bin
          ])
          ++ (with myPkgs; [
            proton-ge-rtsp-bin
          ]);
        extraPackages = with pkgs; [
          json-glib
          libGLU
          libbsd
          libcap
          libuuid
          libxkbcommon
        ];
        remotePlay.openFirewall = true;
      };
    };
    services.monado = {
      defaultRuntime = true;
      enable = true;
      highPriority = true;
    };
    systemd.user.services.monado.environment = {
      U_PACING_COMP_MIN_TIME_MS = "5";
      # XRT_COMPOSITOR_COMPUTE = "1";
      XRT_COMPOSITOR_FORCE_NVIDIA_DISPLAY = "Sony SIE  VRH";
      XRT_COMPOSITOR_FORCE_WAYLAND = "1";
    };
  };
}
