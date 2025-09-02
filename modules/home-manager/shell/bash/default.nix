{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.shell.type;
in
{
  config = mkIf (cfg == "bash") {
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
      initExtra = import ../functions.nix;
      logoutExtra = builtins.readFile ./bash_logout.bash;
      profileExtra = builtins.readFile ./profile.bash;
    };
  };
}
