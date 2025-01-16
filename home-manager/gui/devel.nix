{ pkgs, ... }:
{
  home.packages = with pkgs.jetbrains; [
    clion
    gateway
    idea-ultimate
    phpstorm
    pycharm-professional
    rider
    rust-rover
    webstorm
    writerside
  ];
}
