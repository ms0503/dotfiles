{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.gpu;
in
{
  config =
    (mkIf (cfg == "nvidia") {
      wayland.windowManager.hyprland.settings.env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "NVD_BACKEND,direct"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];
    })
    // (mkIf (cfg == "radeon") { });
}
