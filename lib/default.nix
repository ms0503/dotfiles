inputs: rec {
  inherit (system) mkHomeManagerConfiguration mkNixosSystem;
  const = import ./const.nix inputs;
  network = import ./network.nix inputs;
  system = import ./system.nix inputs;
  types = import ./types.nix inputs;
}
