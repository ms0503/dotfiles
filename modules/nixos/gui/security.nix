{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.gui;
in
{
  config = mkIf cfg.enable {
    programs.seahorse.enable = true;
    security = {
      pam.services = {
        login.enableGnomeKeyring = true;
        swaylock.text = "auth include login";
      };
      polkit.enable = true;
    };
    services.gnome.gnome-keyring.enable = true;
  };
}
