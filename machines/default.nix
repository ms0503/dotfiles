{
  fenix,
  nix-ros-overlay,
  private-pkgs,
  self,
  ...
}:
let
  inherit (self.lib) mkHomeManagerConfiguration mkNixosSystem;
in
{
  home-manager = {
    "ms0503@a15" = mkHomeManagerConfiguration {
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
        ./a15/config-nixos.nix
        ./a15/nixos.nix
      ];
      system = "x86_64-linux";
      username = "ms0503";
    };
  };
}
