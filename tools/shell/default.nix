{
  imports = [
    ./treefmt.nix
    ./git-hooks.nix
  ];
  perSystem =
    {
      config,
      inputs',
      lib,
      pkgs,
      ...
    }:
    {
      devShells = {
        bootstrap = pkgs.mkShell {
          packages = builtins.concatLists [
            (with pkgs; [
              ghq
              git
              gnupg
            ])
            (with inputs'.home-manager.packages; [
              home-manager
            ])
            (with inputs'.neovim-custom.packages; [
              default
            ])
            (with inputs'.nix.packages; [
              nix
            ])
          ];
        };
        default = pkgs.mkShell {
          packages = builtins.concatLists [
            config.pre-commit.settings.enabledPackages
            (config.treefmt.build.programs |> lib.attrValues)
            (with pkgs; [
              nvfetcher
            ])
            (with inputs'.nh.packages; [
              nh
            ])
          ];
          shellHook = ''
            ${config.pre-commit.shellHook}
          '';
        };
      };
    };
}
