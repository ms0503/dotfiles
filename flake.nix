{
  inputs = {
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    rust-overlay = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:oxalica/rust-overlay";
    };
  };
  outputs =
    inputs@{
      home-manager,
      nixpkgs,
      rust-overlay,
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
      homeConfigurations = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {
            inherit inputs;
            username = "ms0503";
          };
          modules = [
            {
              home = {
                homeDirectory = "/home/ms0503";
                packages =
                  (with pkgs; [
                    (writeScriptBin "sync-home" ''
                      nix develop "/home/ms0503/.dotfiles" --command sync-home
                    '')
                  ])
                  ++ (with self.outputs.packages.${system}; [
                    colortool
                    generatehex
                    getcodepoint
                    getemoji
                    matrics
                    unicodeescape
                    urlencode
                    urxvt-wrapper
                  ]);
                stateVersion = "22.11";
                username = "ms0503";
              };
              imports = [ ./config ];
              programs.home-manager.enable = true;
            }
          ];
          pkgs = import nixpkgs { inherit system; };
        }
      );
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ rust-overlay.overlays.default ];
          };
        in
        import ./pkg pkgs
      );
    };
}
# vim: set et sts=2 sw=2 ts=2 :
