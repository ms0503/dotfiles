{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.neovim-custom.packages.${pkgs.system}.default
  ];
}
