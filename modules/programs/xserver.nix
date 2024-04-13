{
  services.xserver = {
    autoRepeatDelay = 300;
    autoRepeatInterval = 30;
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      autoSuspend = false;
      enable = true;
      wayland = true;
    };
    enable = true;
    libinput = {
      enable = true;
      mouse.accelProfile = "flat";
    };
  };
}
