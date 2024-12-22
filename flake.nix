{
  inputs = {
    fenix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/fenix";
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
        }
      );
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          scripts = with pkgs; [
            (writeScriptBin "sync-home" ''
              home-manager switch --flake ".#${system}"
            '')
          ];
        in
        {
          default = pkgs.mkShell { packages = scripts; };
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
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              fenix.overlays.default
            ];
          };
          myPkgs = self.outputs.packages.${system};
        in
        import ./pkgs pkgs
      );
    };
}
# vim: et sts=2 sw=2 ts=2
