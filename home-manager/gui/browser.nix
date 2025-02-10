{
  config,
  myPkgs,
  pkgs,
  ...
}:
{
  home.packages = with myPkgs; [
    (if config.ms0503.wayland.enable then microsoft-edge-dev-wayland else microsoft-edge-dev)
  ];
  programs.firefox = {
    enable = true;
    languagePacks = [
      "en-US"
      "ja"
    ];
    package = pkgs.firefox-devedition;
  };
}
