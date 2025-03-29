_:
{ inputs, ... }:
{
  imports = [
    inputs.git-hooks.flakeModule
  ];
  perSystem =
    { config, ... }:
    {
      pre-commit = {
        check.enable = true;
        settings = {
          hooks = {
            actionlint.enable = true;
            check-json.enable = true;
            check-toml.enable = true;
            editorconfig-checker = {
              enable = true;
              excludes = [
                "flake.lock"
                "machines/a15/BR5350_2_GPL.ppd"
                "themes/.*/wezterm.toml"
              ];
            };
            luacheck.enable = true;
            markdownlint = {
              enable = true;
              settings.configuration.MD013 = false;
            };
            treefmt = {
              enable = true;
              package = config.treefmt.build.wrapper;
            };
            yamlfmt.enable = true;
            yamllint.enable = true;
          };
          src = ./.;
        };
      };
    };
}
