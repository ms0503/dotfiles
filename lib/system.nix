inputs@{
  home-manager,
  lanzaboote,
  misc-tools,
  ms0503-pkgs,
  nh,
  nixpkgs,
  self,
  ...
}:
let
  myLib = self.lib;
in
{
  mkHomeManagerConfiguration =
    {
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
            "electron-25.9.0"
          ];
        };
        overlays = overlays ++ [
          nh.overlays.default
        ];
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
            myLib
            myPkgs
            username
            ;
          theme = (import ../themes) theme;
        };
        modules = [
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
                  matrics
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
          ../home-manager/cli
        ] ++ modules;
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
    in
    withSystem system (
      { inputs', ... }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          lanzaboote.nixosModules.lanzaboote
          (import ../options.nix)
          self.nixosModules.default
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
            inputs'
            myLib
            myPkgs
            username
            ;
        };
      }
    );
}
