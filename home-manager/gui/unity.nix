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
          unity-vrc-2019
          unity-vrc-2022
          unity-vrc-2022-old
        ])
      )
    else
      [ ];
}
