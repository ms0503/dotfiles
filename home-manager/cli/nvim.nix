{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.neovim-custom.packages.${pkgs.system}.default
  ];
}
# vim: et sts=2 sw=2 ts=2
