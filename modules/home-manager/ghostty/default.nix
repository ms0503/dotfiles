{
  config,
  lib,
  theme,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.terminal;
in
{
  config = mkIf (cfg == "ghostty") {
    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      installBatSyntax = true;
      installVimSyntax = true;
      settings = import ./config.nix;
      themes.myTheme = theme.ghostty;
    };
  };
}
