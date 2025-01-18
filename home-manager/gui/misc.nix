{ myPkgs, pkgs, ... }:
{
  home.packages =
    (with pkgs; [
      minecraft
    ])
    ++ (with myPkgs; [
      blender3
    ]);
}
