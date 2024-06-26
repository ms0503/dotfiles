{inputs, pkgs, ...}: {
  home.packages = with pkgs; [
    gnome.evince
    gnome.totem
    inputs.syndicationd.packages.${pkgs.system}.default
    vlc
  ];
  programs = {
    ncspot.enable = true;
    obs-studio.enable = true;
  };
  services.easyeffects.enable = true;
}
