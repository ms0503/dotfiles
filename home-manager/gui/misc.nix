{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (prismlauncher.overrideAttrs (
      _: prev: {
        qtWrapperArgs = prev.qtWrapperArgs ++ [
          "--unset WAYLAND_DISPLAY"
        ];
      }
    ))
  ];
}
