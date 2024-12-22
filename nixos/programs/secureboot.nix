{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    loader.systemd-boot.enable = lib.mkForce false;
  };
  environment.systemPackages = with pkgs; [
    sbctl
  ];
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];
}
# vim: et sts=2 sw=2 ts=2
