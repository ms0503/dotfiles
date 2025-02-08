{ myPkgs, pkgs, ... }:
{
  home.packages =
    (with pkgs; [
      kicad
      minecraft
    ])
    ++ (with myPkgs; [
      blender3
    ]);
}
