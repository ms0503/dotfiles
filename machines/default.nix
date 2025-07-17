{ withSystem, ... }:
{ inputs, ... }:
let
  inherit (inputs)
    fenix
    private-pkgs
    self
    ;
  inherit (self.lib) mkHomeManagerConfiguration mkNixosSystem;
in
{
  flake = {
    homeConfigurations = {
      "ms0503@erebos" = mkHomeManagerConfiguration {
        inherit withSystem;
        modules = [
          ./erebos/config-hm.nix
          ./erebos/home-manager.nix
        ];
        overlays = [
          fenix.overlays.default
          private-pkgs.overlays.default
        ];
        system = "x86_64-linux";
        theme = "monokai";
        username = "ms0503";
      };
      "ms0503@nyx" = mkHomeManagerConfiguration {
        inherit withSystem;
        modules = [
          ./nyx/config-hm.nix
          ./nyx/home-manager.nix
        ];
        overlays = [
          fenix.overlays.default
          private-pkgs.overlays.default
        ];
        system = "x86_64-linux";
        theme = "monokai";
        username = "ms0503";
      };
    };
    nixosConfigurations = {
      erebos = mkNixosSystem {
        inherit withSystem;
        hostname = "erebos";
        modules = [
          ./erebos/config-nixos.nix
          ./erebos/nixos.nix
        ];
        system = "x86_64-linux";
        username = "ms0503";
      };
      nyx = mkNixosSystem {
        inherit withSystem;
        hostname = "nyx";
        modules = [
          ./nyx/config-nixos.nix
          ./nyx/nixos.nix
        ];
        system = "x86_64-linux";
        username = "ms0503";
      };
    };
  };
}
