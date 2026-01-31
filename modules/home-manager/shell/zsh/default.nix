{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.shell.type;
in
{
  config = mkIf (cfg == "zsh") {
    programs.zsh = {
      autocd = true;
      autosuggestion.enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      enable = true;
      enableCompletion = true;
      historySubstringSearch.enable = true;
      initContent = import ../functions.nix;
      prezto = {
        editor.dotExpansion = true;
        enable = true;
        python = {
          virtualenvAutoSwitch = false;
          virtualenvInitialize = false;
        };
        ruby.chrubyAutoSwitch = false;
      };
      syntaxHighlighting = {
        enable = true;
        highlighters = [ ];
      };
    };
  };
}
