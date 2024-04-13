{pkgs, ...}: {
  home.packages = with pkgs; [
    microsoft-edge-dev
  ];
  programs = {
    firefox.enable = true;
    google-chrome.enable = true;
  };
}
