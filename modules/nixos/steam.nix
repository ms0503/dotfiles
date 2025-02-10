{
  config,
  lib,
  myPkgs,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.ms0503.steam;
in
{
  config = mkIf cfg.enable {
    programs.steam = {
      dedicatedServer.openFirewall = true;
      enable = true;
      extraCompatPackages =
        (with pkgs; [
          proton-ge-bin
        ])
        ++ (with myPkgs; [
          proton-ge-rtsp-bin
        ]);
      remotePlay.openFirewall = true;
    };
  };
  options.ms0503.steam.enable = mkEnableOption "a steam";
}
