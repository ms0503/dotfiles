{ inputs', ... }:
{
  nix = {
    extraOptions = ''
      !include nix-secret.conf
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = inputs'.nix.packages.default;
    settings = {
      accept-flake-config = true;
      auto-optimise-store = true;
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      substituters = [
        "https://cache.nixos.org"
        "https://helix.cachix.org"
        "https://hyprland.cachix.org"
        "https://ms0503.cachix.org"
        "https://nix-community.cachix.org"
        "https://ros.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "ms0503.cachix.org-1:Cc2mXpepZr7O9aFcRj5jq3mIcvdUPp85sLFuQj+IKbM="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
      ];
      trusted-users = [
        "@wheel"
        "root"
      ];
    };
  };
  nixpkgs.config.allowUnfree = true;
  programs = {
    nh.enable = true;
    nix-ld.enable = true;
  };
}
