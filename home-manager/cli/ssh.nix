{ lib, ... }:
{
  programs.ssh = {
    enable = true;
    extraConfig = lib.mkDefault "";
    serverAliveCountMax = 5;
    serverAliveInterval = 60;
  };
}
