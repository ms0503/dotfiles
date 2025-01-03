{
  programs.seahorse.enable = true;
  security = {
    pam.services = {
      login.enableGnomeKeyring = true;
      swaylock.text = "auth include login";
    };
    polkit.enable = true;
  };
  services.gnome.gnome-keyring.enable = true;
}
