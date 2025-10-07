{
  config,
  lib,
  myPkgs,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.gui;
in
{
  config = mkIf cfg.enable {
    home.packages = with myPkgs; [
      (if config.ms0503.wayland.enable then microsoft-edge-dev-wayland else microsoft-edge-dev)
    ];
    programs.firefox = {
      enable = true;
      languagePacks = [
        "en-US"
        "ja"
      ];
      package = pkgs.firefox-devedition;
    };
  };
}
