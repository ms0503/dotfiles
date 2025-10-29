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
  };
}
