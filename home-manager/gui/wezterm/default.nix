{
  config,
  inputs,
  pkgs,
  theme,
  ...
}:
{
  home.file = {
    "${config.xdg.configHome}/ranger/rc.conf".text = ''
      set preview_images true
      set preview_images_method iterm2
    '';
    "${config.xdg.configHome}/wezterm/colors/myTheme.toml".text = theme.wezterm;
  };
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
    package = inputs.wezterm.packages.${pkgs.system}.default;
  };
}
