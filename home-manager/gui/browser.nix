{ inputs, pkgs, ... }:
let
  myPkgs = inputs.self.outputs.packages.${pkgs.system};
in
{
  home.packages = with myPkgs; [
    microsoft-edge-dev
  ];
}
# vim: et sts=2 sw=2 ts=2
