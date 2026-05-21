{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.gpu;
in
{
  config = mkIf (cfg == "nvidia") {
    home.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      NVD_BACKEND = "direct";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
