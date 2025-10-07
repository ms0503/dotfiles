{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.media;
  cfgGui = config.ms0503.gui;
in
{
  config = mkIf (cfgGui.enable && cfg.enable) {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      package = pkgs.obs-studio.override {
        cudaSupport = config.ms0503.gpu == "nvidia";
      };
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        obs-gstreamer
        obs-pipewire-audio-capture
        obs-vaapi
        obs-vkcapture
        wlrobs
      ];
    };
  };
}
