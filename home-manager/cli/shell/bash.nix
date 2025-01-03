{ pkgs, theme, ... }:
{
  programs.bash = {
    bashrcExtra = builtins.readFile ./bashrc.bash;
    enable = true;
    historyControl = [
      "ignoreboth"
    ];
    historyIgnore = [
      "cd"
      "exit"
      "ll"
      "lla"
      "ls"
    ];
    initExtra = ''
      ${theme.fzf}
    '';
    logoutExtra = builtins.readFile ./bash_logout.bash;
    profileExtra = builtins.readFile ./profile.bash;
    shellAliases = import ./aliases.nix;
  };
}
