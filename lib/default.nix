args: rec {
  inherit (system) mkHomeManagerConfiguration mkNixosSystem;
  const = import ./const.nix args;
  network = import ./network.nix args;
  system = import ./system.nix args;
}
