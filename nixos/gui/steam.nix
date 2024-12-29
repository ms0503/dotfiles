{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  myPkgs = inputs.self.outputs.packages.${pkgs.system};
in
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
# vim: et sts=2 sw=2 ts=2
