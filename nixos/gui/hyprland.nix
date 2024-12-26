{ config, lib, ... }:
lib.mkIf config.ms0503.gui.enable (lib.mkIf (config.ms0503.desktop == "hyprland") {
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  security.pam.services.swaylock = { };
  services.xremap.withHypr = true;
})
# vim: et sts=2 sw=2 ts=2
