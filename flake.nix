{
  inputs = {
    crane.url = "github:ipetkov/crane";
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
        crane = {
          inputs.nixpkgs.follows = "nixpkgs";
          url = "github:ipetkov/crane/95b42093e50ff889aab558682922251bb70c0f91";
        };
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:sopa0/hyprsome";
    };
    lanzaboote = {
      inputs = {
        crane.follows = "crane";
        nixpkgs.follows = "nixpkgs";
        pre-commit.follows = "";
        rust-overlay.follows = "rust-overlay";
      };
      url = "github:nix-community/lanzaboote";
    };
    ms0503-pkgs = {
      inputs = {
        fenix.follows = "fenix";
        flake-compat.follows = "";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "";
        nixpkgs.follows = "nixpkgs";
        nixpkgs-blender3.follows = "";
        treefmt-nix.follows = "";
      };
      url = "github:ms0503/pkgs.nix";
    };
    neovim-custom = {
      inputs = {
        fenix.follows = "fenix";
        flake-compat.follows = "";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "";
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
    nixos-hardware = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:NixOS/nixos-hardware";
    };
    nixos-wsl = {
      inputs = {
        flake-compat.follows = "";
        nixpkgs.follows = "nixpkgs";
      };
      url = "github:nix-community/NixOS-WSL";
    };
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
        crane.follows = "crane";
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
      "https://helix.cachix.org"
      "https://hyprland.cachix.org"
      "https://ms0503.cachix.org"
      "https://nix-community.cachix.org"
      "https://nix-ros.cachix.org"
      "https://nixpkgs-unfree.cachix.org"
      "https://ros.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "ms0503.cachix.org-1:Cc2mXpepZr7O9aFcRj5jq3mIcvdUPp85sLFuQj+IKbM="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-ros.cachix.org-1:e1GCZW6WLNkQ0t0s7zsQz8c7+UoGvTkkq023FWSAtfQ="
      "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
      "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
    ];
  };
  outputs =
    prevInputs@{
      flake-parts,
      nixpkgs,
      systems,
      ...
    }:
    let
      inputs = nixpkgs.lib.mergeAttrsList [
        prevInputs
        {
          private-pkgs = builtins.getFlake "github:ms0503/private-pkgs.nix/b11c013de609eb315bcff990d845e188cccb589e";
        }
      ];
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
          ./tools/treefmt.nix
          ./tools/git-hooks.nix
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
