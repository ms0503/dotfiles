inputs@{
  home-manager,
  lanzaboote,
  misc-tools,
  ms0503-pkgs,
  neovim-custom,
  nh,
  nixos-wsl,
  nixpkgs,
  nixpkgs-2505,
  self,
  xremap,
  ...
}:
let
  myLib = self.lib;
in
{
  mkHomeManagerConfiguration =
    {
      isNixOS ? true,
      modules,
      overlays,
      system,
      theme,
      username,
      withSystem,
    }:
    let
      myPkgs = ms0503-pkgs.packages.${system} // self.outputs.packages.${system};
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowBroken = true;
          allowUnfree = true;
          permittedInsecurePackages = [
            "freeimage-3.18.0-unstable-2024-04-18"
            "qtwebkit-5.212.0-alpha4"
          ];
        };
        overlays = overlays ++ [
          nh.overlays.default
          self.overlays.default
        ];
      };
      pkgs2505 = import nixpkgs-2505 {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "openssl-1.1.1w"
          ];
        };
      };
    in
    withSystem system (
      { inputs', ... }:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit
            inputs
            inputs'
            isNixOS
            myLib
            myPkgs
            pkgs2505
            username
            ;
          theme = (import ../themes) theme;
        };
        modules = [
          neovim-custom.homeManagerModules.default
          (import ../options.nix)
          self.homeManagerModules.default
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
                  skel
                  swww-bing
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
        ]
        ++ modules;
      }
    );
  mkNixosSystem =
    {
      hostname,
      modules,
      system,
      username,
      withSystem,
    }:
    let
      myPkgs = ms0503-pkgs.packages.${system} // self.outputs.packages.${system};
      pkgs2505 = import nixpkgs-2505 {
        inherit system;
      };
    in
    withSystem system (
      { inputs', ... }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          lanzaboote.nixosModules.lanzaboote
          neovim-custom.nixosModules.default
          nixos-wsl.nixosModules.default
          xremap.nixosModules.default
          (import ../options.nix)
          self.nixosModules.default
          {
            nixpkgs.overlays = [
              nh.overlays.default
              self.overlays.default
            ];
            users.extraGroups.vboxusers.members = [
              username
            ];
          }
        ]
        ++ modules;
        specialArgs = {
          inherit
            hostname
            inputs
            inputs'
            myLib
            myPkgs
            pkgs2505
            username
            ;
        };
      }
    );
}
