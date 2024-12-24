{ lib, ... }:
{
  programs.ssh = {
    enable = true;
    extraConfig = lib.mkDefault "";
    serverAliveCountMax = 5;
    serverAliveInterval = 60;
  };
}
# vim: et sts=2 sw=2 ts=2
