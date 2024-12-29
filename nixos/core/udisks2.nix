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
# vim: et sts=2 sw=2 ts=2
