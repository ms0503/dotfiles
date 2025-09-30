{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.steam;
in
{
  config = mkIf cfg.enable {
    xdg.configFile = {
      "openvr/openvrpaths.vrpath".text = ''
        {
          "config": [
            "${config.xdg.dataHome}/Steam/config"
          ],
          "external_drivers": [],
          "jsonid": "vrpathreg",
          "log": [
            "${config.xdg.dataHome}/Steam/logs"
          ],
          "runtime": [
            "${pkgs.opencomposite}/lib/opencomposite"
          ],
          "version": 1
        }
      '';
      "openxr/1/active_runtime.json".source = "${pkgs.monado}/share/openxr/1/openxr_monado.json";
    };
  };
}
