{ theme, ... }:
{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    settings = import ./config.nix;
    themes.myTheme = theme.ghostty;
  };
}
