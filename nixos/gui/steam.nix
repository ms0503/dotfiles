{ config, lib, ... }:
lib.mkIf config.ms0503.steam.enable {
  programs.steam = {
    dedicatedServer.openFirewall = true;
    enable = true;
    remotePlay.openFirewall = true;
  };
}
# vim: et sts=2 sw=2 ts=2
