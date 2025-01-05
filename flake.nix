{
  inputs = {
    fenix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/fenix";
    };
    flake-compat.url = "github:edolstra/flake-compat";
    git-hooks = {
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/git-hooks.nix";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-24.11";
    };
    hyprland = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hyprwm/Hyprland";
    };
    hyprsome = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:sopa0/hyprsome";
    };
    lanzaboote = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/lanzaboote";
    };
    misc-tools = {
      inputs = {
        fenix.follows = "fenix";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:ms0503/misc-tools";
    };
    ms0503-pkgs = {
      inputs = {
        fenix.follows = "fenix";
        flake-compat.follows = "flake-compat";
        git-hooks.follows = "git-hooks";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:ms0503/pkgs.nix";
    };
    neovim-custom = {
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs";
      };
      url = "github:ms0503/neovim-custom";
    };
    nix-ros-overlay = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:lopsided98/nix-ros-overlay";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix";
    };
    wezterm = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:wez/wezterm?dir=nix";
    };
    xremap = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:xremap/nix-flake";
    };
  };
  outputs =
    inputs@{
      fenix,
      git-hooks,
      nixpkgs,
      self,
      treefmt-nix,
      ...
    }:
    let
      allSystems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs allSystems;
    in
    {
      checks = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
        in
        {
          formatting = treefmtEval.config.build.check self;
          pre-commit-check = git-hooks.lib.${system}.run {
            hooks = {
              actionlint.enable = true;
              check-json.enable = true;
              check-toml.enable = true;
              editorconfig-checker = {
                enable = true;
                excludes = [
                  "flake.lock"
                  "themes/.*/wezterm.toml"
                ];
              };
              luacheck.enable = true;
              markdownlint.enable = true;
              treefmt = {
                enable = true;
                package = treefmtEval.config.build.wrapper;
              };
              yamlfmt.enable = true;
              yamllint.enable = true;
            };
            src = ./.;
          };
        }
      );
      devShells = forAllSystems (
        system:
        let
          packages = preCommitCheck.enabledPackages
          #++ with pkgs; []
          ;
          pkgs = import nixpkgs { inherit system; };
          preCommitCheck = self.checks.${system}.pre-commit-check;
        in
        {
          default = pkgs.mkShell {
            inherit packages;
            inherit (preCommitCheck) shellHook;
          };
        }
      );
      formatter = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
        in
        treefmtEval.config.build.wrapper
      );
      homeConfigurations = (import ./machines inputs).home-manager;
      nixosConfigurations = (import ./machines inputs).nixos;
      overlays = import ./overlays;
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              fenix.overlays.default
            ];
          };
        in
        import ./pkgs pkgs
      );
    };
}
