{ inputs, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
  ];
  perSystem =
    { pkgs, ... }:
    {
      treefmt.programs = {
        mdformat = {
          enable = true;
          plugins =
            ps: with ps; [
              mdformat-gfm
            ];
          settings = {
            end-of-line = "lf";
            number = true;
            wrap = 80;
          };
        };
        nixfmt = {
          enable = true;
          excludes = [
            "_sources/generated.nix"
          ];
        };
        shellcheck = {
          enable = true;
          excludes = [
            ".envrc"
          ];
        };
        shfmt = {
          enable = true;
          indent_size = 4;
        };
        stylua.enable = true;
        taplo.enable = true;
      };
    };
}
