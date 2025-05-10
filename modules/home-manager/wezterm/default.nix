{
  config,
  inputs',
  lib,
  theme,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.terminal;
  wezimgcat-wrapper = inputs'.ms0503-pkgs.packages.wezimgcat-wrapper;
in
{
  config = mkIf (cfg == "wezterm") {
    home = {
      file = {
        "${config.xdg.configHome}/ranger/rc.conf".text = ''
          set preview_images true
          set preview_images_method iterm2
        '';
        "${config.xdg.configHome}/wezterm/colors/myTheme.toml".text = theme.wezterm;
      };
      packages = [
        inputs'.wezterm.packages.default.terminfo
      ];
      sessionVariables.TERM = "wezterm";
    };
    ms0503.bash.aliases.imgcat = "${wezimgcat-wrapper}/bin/wezimgcat-wrapper";
    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./wezterm.lua;
      package = inputs'.wezterm.packages.default;
    };
  };
}
