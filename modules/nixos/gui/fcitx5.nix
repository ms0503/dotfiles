{
  config,
  inputs',
  lib,
  myLib,
  myPkgs,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    optional
    optionalAttrs
    ;
  cfg = config.ms0503.im;
  cfgGui = config.ms0503.gui;
  cfgWayland = config.ms0503.wayland;
  types = lib.types // myLib.types;
in
{
  config = mkIf (cfgGui.enable && cfg.enable) {
    assertions = [
      {
        assertion = cfg.type != null;
        message = "ms0503.im.type must not be null";
      }
    ];
    i18n.inputMethod = {
      enable = true;
      fcitx5 = {
        addons =
          with pkgs;
          with myPkgs;
          (
            optional (cfg.type == "karukan") karukan
            ++ optional (cfg.type == "mozc") fcitx5-mozc
            ++ optional (cfg.type == "mozc-ut") fcitx5-mozc-ut
          );
        waylandFrontend = cfgWayland.enable;
      };
      type = "fcitx5";
    };
    services = optionalAttrs (cfg.type == "hazkey") {
      hazkey = {
        enable = true;
      }
      // optionalAttrs cfg.hazkey.enableGpu {
        server.package = inputs'.nix-hazkey.packages.hazkey-server.override {
          enableVulkan = true;
        };
      };
    };
  };
  options.ms0503.im = {
    enable = mkEnableOption "an input method";
    hazkey.enableGpu = mkEnableOption "GPU support";
    type = mkOption {
      default = null;
      description = "Choose an input method to use";
      type = types.nullOr types.ims;
    };
  };
}
