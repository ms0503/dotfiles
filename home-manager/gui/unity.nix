{
  config,
  inputs,
  pkgs,
  ...
}:
let
  myPkgs = inputs.self.outputs.packages.${pkgs.system};
in
{
  home.packages =
    if config.ms0503.unity.enable then
      (
        (with pkgs; [
          unityhub
        ])
        ++ (with myPkgs; [
          alcom
        ])
      )
    else
      [ ];
}
# vim: et sts=2 sw=2 ts=2
