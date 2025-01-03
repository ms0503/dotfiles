{ pkgs, username, ... }:
{
  nix = {
    package = pkgs.nix;
    settings = {
      accept-flake-config = true;
      auto-optimise-store = true;
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      trusted-users = [
        "root"
        "${username}"
      ];
    };
  };
}
