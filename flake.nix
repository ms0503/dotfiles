{
  inputs = {
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    lanzaboote = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/lanzaboote/v0.3.0";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    syndicationd.url = "github:ymgyt/syndicationd";
    xremap.url = "github:xremap/nix-flake";
  };
  outputs = inputs@{nixpkgs, ...}: let
    allSystems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs allSystems;
    hosts = import ./hosts inputs;
  in {
    devShells = forAllSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
      scripts = with pkgs; [
        (writeScriptBin "switch-home" ''
          home-manager switch --flake ".#$@"
        '')
        (writeScriptBin "switch-nixos" ''
          sudo nixos-rebuild switch --flake ".#$@"
        '')
      ];
    in {
      default = pkgs.mkShell {
        packages = scripts;
      };
    });
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);
    homeConfigurations = hosts.home-manager;
    nixosConfigurations = hosts.nixos;
  };
}
