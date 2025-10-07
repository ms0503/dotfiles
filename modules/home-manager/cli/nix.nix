{
  isNixOS,
  lib,
  pkgs,
  username,
  ...
}:
{
  nix = {
    package = pkgs.nix;
    settings = {
      accept-flake-config = true;
      auto-optimise-store = true;
      experimental-features = [
        "flakes"
        "nix-command"
        "pipe-operators"
      ];
      trusted-users = [
        "${username}"
        "@wheel"
        "root"
      ];
    };
  }
  // lib.optionalAttrs (!isNixOS) {
    extraOptions = ''
      !include nix-secret.conf
    '';
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    settings = {
      substituters = [
        "https://helix.cachix.org"
        "https://hyprland.cachix.org"
        "https://ms0503.cachix.org"
        "https://nix-community.cachix.org"
        "https://nix-ros.cachix.org"
        "https://ros.cachix.org"
      ];
      trusted-public-keys = [
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "ms0503.cachix.org-1:Cc2mXpepZr7O9aFcRj5jq3mIcvdUPp85sLFuQj+IKbM="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-ros.cachix.org-1:e1GCZW6WLNkQ0t0s7zsQz8c7+UoGvTkkq023FWSAtfQ="
        "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
      ];
    };
  };
}
