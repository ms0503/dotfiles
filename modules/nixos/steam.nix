{
  config,
  lib,
  myPkgs,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf optional;
  cfg = config.ms0503.steam;
in
{
  config = mkIf cfg.enable {
    boot.kernelPatches = optional (config.ms0503.gpu == "radeon") {
      name = "amdgpu-ignore-ctx-privileges";
      patch = pkgs.fetchpatch {
        hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
        name = "cap_sys_nice_begone.patch";
        url = "https://github.com/Frogging-Family/community-patches/raw/cbcc5e4d72d22fc08afe81bb517a54b0e01515a5/linux61-tkg/cap_sys_nice_begone.mypatch";
      };
    };
    environment.systemPackages = with pkgs; [
      wayvr
    ];
    programs = {
      steam = {
        dedicatedServer.openFirewall = true;
        enable = true;
        extest.enable = true;
        extraCompatPackages = builtins.concatLists [
          (with pkgs; [
            proton-ge-bin
          ])
          (with myPkgs; [
            proton-ge-rtsp-bin
          ])
        ];
        extraPackages = with pkgs; [
          json-glib
          libGLU
          libbsd
          libcap
          libuuid
          libxkbcommon
        ];
        localNetworkGameTransfers.openFirewall = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;
      };
    };
    services = {
      monado = {
        defaultRuntime = true;
        enable = true;
      };
      wivrn = {
        autoStart = true;
        enable = true;
        highPriority = true;
        openFirewall = true;
        package = pkgs.wivrn.override {
          cudaSupport = true;
        };
        steam = {
          enable = true;
          importOXRRuntimes = true;
        };
      };
    };
    systemd.user.services.monado.environment = {
      STEAMVR_LH_ENABLE = "1";
      XRT_COMPOSITOR_COMPUTE = "1";
    };
  };
}
