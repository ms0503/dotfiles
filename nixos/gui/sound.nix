{
  security.rtkit.enable = true;
  services = {
    pipewire = {
      alsa = {
        enable = true;
        support32Bit = true;
      };
      enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
    pulseaudio.enable = false;
  };
}
