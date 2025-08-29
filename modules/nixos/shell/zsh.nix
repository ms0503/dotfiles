{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.ms0503.shell.type;
in
{
  config = mkIf (cfg == "zsh") {
    users.users."${username}".shell = pkgs.zsh;
  };
}
