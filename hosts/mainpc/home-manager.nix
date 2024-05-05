{pkgs, ...}: let
  dotnet = pkgs.dotnet-sdk_8;
in {
  home.packages = [
    dotnet
  ];
  imports = [
    ../../home-manager/cli
    ../../home-manager/gui
    ../../home-manager/desktop/gnome
  ];
  programs.bash.profileExtra = (builtins.readFile ../../home-manager/cli/bash/.profile) + ''
    export DOTNET_ROOT=${dotnet}
  '';
}
