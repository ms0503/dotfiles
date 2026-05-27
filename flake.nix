{
  inputs = {
    fenix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/fenix";
    };
    flake-compat = {
      flake = false;
      url = "github:NixOS/flake-compat";
    };
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
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:sopa0/hyprsome";
    };
    lanzaboote = {
      inputs = {
        nixpkgs.follows = "nixpkgs";
        pre-commit.follows = "";
      };
      url = "github:nix-community/lanzaboote";
    };
    ms0503-pkgs = {
      inputs = {
        fenix.follows = "fenix";
        flake-compat.follows = "";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
        nixpkgs.follows = "nixpkgs";
        nixpkgs-blender3.follows = "";
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
    nix-hazkey = {
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:aster-void/nix-hazkey";
    };
    nix-index = {
      inputs = {
        flake-compat.follows = "";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:nix-community/nix-index";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixos-wsl = {
      inputs = {
        flake-compat.follows = "";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:nix-community/NixOS-WSL";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
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
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:xremap/nix-flake";
    };
  };
  nixConfig = {
    experimental-features = [
      "flakes"
      "nix-command"
      "pipe-operators"
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://ms0503.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "ms0503.cachix.org-1:Cc2mXpepZr7O9aFcRj5jq3mIcvdUPp85sLFuQj+IKbM="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  outputs =
    prevInputs@{ flake-parts, systems, ... }:
    let
      inputs = prevInputs // {
        private-pkgs = builtins.getFlake "github:ms0503/private-pkgs.nix/b11c013de609eb315bcff990d845e188cccb589e";
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } (
      { withSystem, ... }:
      {
        flake = {
          homeManagerModules = import ./modules/home-manager;
          lib = import ./lib {
            inherit inputs withSystem;
          };
          nixosModules = import ./modules/nixos;
          overlays = import ./overlays;
        };
        imports = [
          ./treefmt.nix
          ./git-hooks.nix
          ./pkgs
          ./machines
        ];
        perSystem =
          {
            config,
            inputs',
            lib,
            pkgs,
            system,
            ...
          }:
          {
            devShells = {
              bootstrap = pkgs.mkShell {
                packages =
                  (with pkgs; [
                    ghq
                    git
                    gnupg
                  ])
                  ++ (with inputs'.home-manager.packages; [
                    home-manager
                  ])
                  ++ (with inputs'.neovim-custom.packages; [
                    default
                  ])
                  ++ (with inputs'.nix.packages; [
                    nix
                  ]);
              };
              default = pkgs.mkShell {
                packages =
                  config.pre-commit.settings.enabledPackages
                  ++ (config.treefmt.build.programs |> lib.attrValues)
                  ++ (with pkgs; [
                    nvfetcher
                  ])
                  ++ (with inputs'.nh.packages; [
                    nh
                  ]);
                shellHook = ''
                  ${config.pre-commit.shellHook}
                '';
              };
            };
          };
        systems = import systems;
      }
    );
}
