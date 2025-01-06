{
  inputs = {
    fenix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/fenix";
    };
    flake-compat.url = "github:edolstra/flake-compat";
    flake-parts = {
      inputs.nixpkgs-lib.follows = "nixpkgs";
      url = "github:hercules-ci/flake-parts";
    };
    git-hooks = {
      inputs = {
        flake-compat.follows = "";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/git-hooks.nix";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-24.11";
    };
    hyprland = {
      inputs = {
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks.follows = "";
      };
      url = "github:hyprwm/Hyprland";
    };
    hyprsome = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:sopa0/hyprsome";
    };
    lanzaboote = {
      inputs = {
        flake-compat.follows = "";
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks-nix.follows = "";
      };
      url = "github:nix-community/lanzaboote";
    };
    misc-tools = {
      inputs = {
        fenix.follows = "fenix";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "";
      };
      url = "github:ms0503/misc-tools";
    };
    ms0503-pkgs = {
      inputs = {
        fenix.follows = "fenix";
        flake-compat.follows = "";
        git-hooks.follows = "";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "";
      };
      url = "github:ms0503/pkgs.nix";
    };
    neovim-custom = {
      inputs = {
        fenix.follows = "fenix";
        flake-compat.follows = "";
        git-hooks.follows = "";
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs";
        treefmt-nix.follows = "";
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
      inputs = {
        home-manager.follows = "home-manager";
        hyprland.follows = "hyprland";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "";
      };
      url = "github:xremap/nix-flake";
    };
  };
  outputs =
    prevInputs@{
      fenix,
      flake-parts,
      git-hooks,
      nixpkgs,
      self,
      treefmt-nix,
      ...
    }:
    let
      inputs = prevInputs // {
        private-pkgs = builtins.getFlake "github:ms0503/private-pkgs.nix/0af54ac840a27addfdf7f3475e65cee7692595d0";
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {
        homeConfigurations = (import ./machines inputs).home-manager;
        nixosConfigurations = (import ./machines inputs).nixos;
        overlays = import ./overlays;
      };
      imports = [
        git-hooks.flakeModule
        treefmt-nix.flakeModule
      ];
      perSystem =
        {
          config,
          pkgs,
          system,
          ...
        }:
        {
          devShells.default = pkgs.mkShell { };
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
                    "themes/.*/wezterm.toml"
                  ];
                };
                luacheck.enable = true;
                markdownlint.enable = true;
                yamlfmt.enable = true;
                yamllint.enable = true;
              };
              src = ./.;
            };
          };
          treefmt = import ./treefmt.nix;
        };
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
    };
}
