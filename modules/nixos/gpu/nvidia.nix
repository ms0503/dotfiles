{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.gpu;
in
{
  config = mkIf (cfg == "nvidia") {
    boot.kernelParams = [
      "nvidia.NVreg_EnableS0ixPowerManagement=1"
    ];
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          libva-vdpau-driver
          nvidia-vaapi-driver
          ocl-icd
        ];
      };
      nvidia = {
        modesetting.enable = true;
        nvidiaSettings = true;
        open = true;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
        powerManagement.enable = false;
      };
    };
    services.xserver.videoDrivers = [
      "nvidia"
    ];
  };
}
