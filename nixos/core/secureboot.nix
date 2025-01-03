{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.ms0503.secureboot.enable {
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
}
