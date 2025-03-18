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
      home-manager,
      nixpkgs,
      self,
      systems,
      ...
    }:
    let
      inputs = prevInputs // {
        private-pkgs = builtins.getFlake "github:ms0503/private-pkgs.nix/dbf0b2c749da73cb6b99316e0dce495de5b12b1e";
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } (
      { flake-parts-lib, withSystem, ... }:
      let
        inherit (flake-parts-lib) importApply;
        git-hooks = importApply ./git-hooks.nix { };
        machines = importApply ./machines { inherit withSystem; };
        treefmt = importApply ./treefmt.nix { };
      in
      {
        flake = {
          homeManagerModules = import ./modules/home-manager;
          lib = import ./lib inputs;
          nixosModules = import ./modules/nixos;
          overlays = import ./overlays inputs;
        };
        imports = [
          git-hooks
          machines
          treefmt
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
              shellHook = ''
                ${config.pre-commit.installationScript}
              '';
            };
          };
        systems = import systems;
      }
    );
}
