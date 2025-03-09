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
    flake-utils.url = "github:numtide/flake-utils";
    git-hooks = {
      inputs = {
        flake-compat.follows = "";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:cachix/git-hooks.nix";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    hyprland = {
      inputs = {
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks.follows = "";
      };
      url = "github:hyprwm/Hyprland";
    };
    hyprsome = {
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:sopa0/hyprsome";
    };
    lanzaboote = {
      inputs = {
        flake-compat.follows = "";
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks-nix.follows = "";
        rust-overlay.follows = "rust-overlay";
      };
      url = "github:nix-community/lanzaboote";
    };
    misc-tools = {
      inputs = {
        flake-compat.follows = "";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:ms0503/misc-tools";
    };
    ms0503-pkgs = {
      inputs = {
        flake-compat.follows = "";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:ms0503/pkgs.nix";
    };
    neovim-custom = {
      inputs = {
        fenix.follows = "fenix";
        flake-compat.follows = "";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:ms0503/neovim-custom";
    };
    nh = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:viperML/nh";
    };
    nix = {
      inputs = {
        flake-compat.follows = "";
        flake-parts.follows = "flake-parts";
        git-hooks-nix.follows = "";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:NixOS/nix";
    };
    nix-ros-overlay = {
      inputs.flake-utils.follows = "flake-utils";
      # url = "github:lopsided98/nix-ros-overlay/master";
      url = "github:lopsided98/nix-ros-overlay/develop";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-firefox.url = "github:khaneliman/nixpkgs/firefox"; # See https://github.com/NixOS/nixpkgs/pull/387931
    rust-overlay = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:oxalica/rust-overlay";
    };
    systems.url = "github:nix-systems/default";
    treefmt-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/treefmt-nix";
    };
    wezterm = {
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
        rust-overlay.follows = "rust-overlay";
      };
      url = "github:wez/wezterm?dir=nix";
    };
    xremap = {
      inputs = {
        flake-parts.follows = "flake-parts";
        home-manager.follows = "home-manager";
        hyprland.follows = "hyprland";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
      url = "github:xremap/nix-flake";
    };
  };
  outputs =
    prevInputs@{
      fenix,
      flake-parts,
      git-hooks,
      home-manager,
      nixpkgs,
      self,
      systems,
      treefmt-nix,
      ...
    }:
    let
      inputs = prevInputs // {
        private-pkgs = builtins.getFlake "github:ms0503/private-pkgs.nix/509514bfd02615c06d9ccba100c4fa87756af11d";
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } (
      { flake-parts-lib, withSystem, ... }:
      let
        inherit (flake-parts-lib) importApply;
        machines = importApply ./machines { inherit withSystem; };
      in
      {
        flake = {
          homeManagerModules = import ./modules/home-manager;
          lib = import ./lib inputs;
          nixosModules = import ./modules/nixos;
          overlays = import ./overlays inputs;
        };
        imports = [
          git-hooks.flakeModule
          machines
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
            devShells.default = pkgs.mkShell {
              packages = with pkgs; [
                nvfetcher
              ];
            };
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
      }
    );
}
