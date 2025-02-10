inputs: rec {
  inherit (system) mkHomeManagerConfiguration mkNixosSystem;
  system = import ./system.nix inputs;
  types = import ./types.nix inputs;
}
