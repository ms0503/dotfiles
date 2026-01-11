{
  config,
  lib,
  myLib,
  pkgs,
  ...
}:
let
  inherit (config.ms0503) feature-set;
  inherit (lib) optionals;
  inherit (myLib) const;
in
{
  home.packages =
    optionals (const.feature-sets.lite <= feature-set) (
      with pkgs;
      [
        fastfetch
      ]
    )
    ++ optionals (const.feature-sets.full <= feature-set) (
      with pkgs;
      [
        cava
        sl
      ]
    );
}
