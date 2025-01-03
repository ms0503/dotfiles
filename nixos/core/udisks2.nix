{
  services = {
    udev.extraRules = ''
      ENV{UDISKS_AUTO}="1"
    '';
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };
}
