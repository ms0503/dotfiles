{
  inputs = {
    fenix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/fenix";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    hyprland = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hyprwm/Hyprland";
    };
    hyprsome = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:sopa0/hyprsome";
    };
    neovim-custom = {
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs-stable";
      };
      url = "github:ms0503/neovim-custom";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-24.11";
  };
  outputs =
    inputs@{
      fenix,
      nixpkgs,
      self,
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
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
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
        import ./pkg pkgs
      );
    };
}
# vim: et sts=2 sw=2 ts=2
