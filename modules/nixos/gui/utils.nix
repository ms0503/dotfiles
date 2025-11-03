{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.gui;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vial
    ];
    programs.dconf.enable = true;
    services.udev.packages = [
      (pkgs.writeTextFile {
        destination = "/etc/udev/rules.d/59-vial.rules";
        name = "vial-udev-rules";
        text = ''
          KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0666", TAG+="uaccess", TAG+="udev-acl"
        '';
      })
    ];
  };
}
