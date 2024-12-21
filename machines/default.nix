inputs@{
  fenix,
  home-manager,
  nixpkgs,
  nixpkgs-stable,
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
        inherit overlays system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "electron-25.9.0"
          ];
        };
      };
    in
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs username;
        pkgs-stable = import nixpkgs-stable {
          inherit overlays system;
          config.allowUnfree = true;
        };
        theme = (import ../themes) "tokyonight-night";
      };
      modules = modules ++ [
        {
          home = {
            homeDirectory = "/home/${username}";
            inherit username;
            packages =
              (with pkgs; [
                (writeScriptBin "sync-home" ''
                  nix develop "/home/${username}/.dotfiles" --command sync-home
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
            stateVersion = "24.11";
          };
          programs = {
            home-manager.enable = true;
            git.enable = true;
          };
        }
      ];
    };
  mkNixosSystem =
    {
      hostname,
      modules,
      system,
      username,
    }:
    nixpkgs.lib.nixosSystem {
      inherit modules system;
      specialArgs = {
        inherit hostname inputs username;
      };
    };
in
{
  home-manager = {
    mainpc = mkHomeManagerConfiguration {
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
  nixos = { };
}
# vim: et sts=2 sw=2 ts=2
