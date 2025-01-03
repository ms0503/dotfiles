{ pkgs, ... }:
{
  programs = {
    jsonfmt.enable = true;
    mdformat.enable = true;
    nixfmt.enable = true;
    rustfmt = {
      edition = "2021";
      enable = true;
    };
    shellcheck.enable = true;
    shfmt = {
      enable = true;
      indent_size = 4;
    };
    stylua.enable = true;
    taplo.enable = true;
  };
}
