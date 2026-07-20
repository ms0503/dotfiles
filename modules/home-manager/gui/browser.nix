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
      microsoft-edge-dev
    ];
    programs.firefox = {
      configPath = "${config.xdg.configHome}/mozilla/firefox";
      enable = true;
      languagePacks = [
        "en-US"
        "ja"
      ];
      package = pkgs.firefox-devedition;
    };
  };
}
