{
  config,
  lib,
  myPkgs,
  pkgs,
  ...
}:
lib.mkIf config.ms0503.steam.enable {
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
}
