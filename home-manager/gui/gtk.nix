{pkgs, ...}: {
  gtk = {
    enable = true;
    iconTheme = {
      name = "hicolor";
      package = pkgs.hicolor-icon-theme;
    };
    theme = {
      name = "Yaru Dark";
      package = pkgs.yaru-theme;
    };
  };
}
