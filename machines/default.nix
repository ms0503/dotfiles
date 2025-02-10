inputs@{
  fenix,
  home-manager,
  lanzaboote,
  misc-tools,
  nh,
  nix-ros-overlay,
  nixpkgs,
  private-pkgs,
  ...
}:
let
  mkHomeManagerConfiguration =
    {
      modules,
      overlays,
      system,
      theme,
      username,
    }:
    let
      myPkgs = inputs.ms0503-pkgs.packages.${system} // inputs.self.outputs.packages.${system};
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowBroken = true;
          allowUnfree = true;
          permittedInsecurePackages = [
            "electron-25.9.0"
          ];
        };
        overlays = overlays ++ [
          nh.overlays.default
        ];
      };
    in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs myPkgs username;
        theme = (import ../themes) theme;
      };
      modules = [
        (import ../options.nix)
        {
          home = {
            inherit username;
            homeDirectory = "/home/${username}";
            packages = (
              with misc-tools.packages.${system};
              [
                colortool
                generatehex
                getcodepoint
                getemoji
                matrics
                unicodeescape
                urlencode
              ]
            );
            stateVersion = "24.11";
          };
          programs = {
            home-manager.enable = true;
            git.enable = true;
          };
        }
        ../home-manager/cli
      ] ++ modules;
    };
  mkNixosSystem =
    {
      hostname,
      modules,
      system,
      username,
    }:
    let
      myPkgs = inputs.ms0503-pkgs.packages.${system} // inputs.self.outputs.packages.${system};
    in
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        lanzaboote.nixosModules.lanzaboote
        (import ../options.nix)
        {
          nixpkgs.overlays = [
            nh.overlays.default
          ];
        }
      ] ++ modules;
      specialArgs = {
        inherit
          hostname
          inputs
          myPkgs
          username
          ;
      };
    };
in
{
  home-manager = {
    "ms0503@a15" = mkHomeManagerConfiguration {
      modules = [
        ./a15/config.nix
        ./a15/home-manager.nix
      ];
      overlays = [
        fenix.overlays.default
        nix-ros-overlay.overlays.default
        private-pkgs.overlays.default
      ];
      system = "x86_64-linux";
      theme = "chalk";
      username = "ms0503";
    };
    "ms0503@mainpc" = mkHomeManagerConfiguration {
      modules = [
        ./mainpc/home-manager.nix
      ];
      overlays = [
        fenix.overlays.default
      ];
      system = "x86_64-linux";
      theme = "chalk";
      username = "ms0503";
    };
  };
  nixos = {
    a15 = mkNixosSystem {
      hostname = "a15";
      modules = [
        ./a15/config.nix
        ./a15/nixos.nix
      ];
      system = "x86_64-linux";
      username = "ms0503";
    };
  };
}
