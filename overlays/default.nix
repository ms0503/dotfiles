{ nixpkgs-firefox, ... }:
{
  default = (
    final: prev: {
      inherit (nixpkgs-firefox.legacyPackages.${final.system}) firefox-devedition;
    }
  );
}
