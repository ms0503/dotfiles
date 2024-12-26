{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  i18n.inputMethod.fcitx5.waylandFrontend = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  security.pam.services.swaylock = { };
  services.xremap.withHypr = true;
}
# vim: et sts=2 sw=2 ts=2
