{
  config,
  myPkgs,
  pkgs,
  ...
}:
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
