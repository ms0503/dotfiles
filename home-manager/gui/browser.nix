{ config, inputs, pkgs, ... }:
let
  microsoft-edge-dev-wayland = myPkgs.microsoft-edge-dev.override (_: {
    commandLineArgs = "--disable-gpu-compositing";
  });
  myPkgs = inputs.self.outputs.packages.${pkgs.system};
in
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
# vim: et sts=2 sw=2 ts=2
