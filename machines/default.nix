{ withSystem, ... }:
{ inputs, ... }:
let
  inherit (inputs)
    fenix
    nix-ros-overlay
    private-pkgs
    self
    ;
  inherit (self.lib) mkHomeManagerConfiguration mkNixosSystem;
in
{
  flake = {
    homeConfigurations = {
      "ms0503@a15" = mkHomeManagerConfiguration {
        inherit withSystem;
        modules = [
          ./a15/config-hm.nix
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
        inherit withSystem;
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
    nixosConfigurations = {
      a15 = mkNixosSystem {
        inherit withSystem;
        hostname = "a15";
        modules = [
          ./a15/config-nixos.nix
          ./a15/nixos.nix
        ];
        system = "x86_64-linux";
        username = "ms0503";
      };
    };
  };
}
