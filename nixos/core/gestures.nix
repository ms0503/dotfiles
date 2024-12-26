{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libinput-gestures
  ];
  services.libinput.enable = true;
}
# vim: et sts=2 sw=2 ts=2
