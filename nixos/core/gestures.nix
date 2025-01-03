{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libinput-gestures
  ];
  services.libinput.enable = true;
}
