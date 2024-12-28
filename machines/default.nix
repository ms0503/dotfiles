inputs@{
  fenix,
  home-manager,
  lanzaboote,
  misc-tools,
  nix-ros-overlay,
  nixpkgs,
  self,
  ...
}:
let
  mkHomeManagerConfiguration =
    {
      modules,
      overlays,
      system,
      username,
    }:
    let
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "electron-25.9.0"
          ];
        };
        overlays = overlays ++ (with self.outputs.overlays; [
          fonts
        ]);
      };
    in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs username;
        theme = (import ../themes) "tokyonight-night";
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
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        lanzaboote.nixosModules.lanzaboote
        (import ../options.nix)
        {
          nixpkgs.overlays = with self.outputs.overlays; [
            fonts
          ];
        }
      ] ++ modules;
      specialArgs = {
        inherit hostname inputs username;
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
      ];
      system = "x86_64-linux";
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
# vim: et sts=2 sw=2 ts=2
