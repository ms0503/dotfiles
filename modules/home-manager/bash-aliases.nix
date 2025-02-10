{ config, lib, ... }:
let
  inherit (lib) mkIf mkOption types;
  cfg = config.ms0503.bash.aliases;
  cfgBash = config.programs.bash;
in
{
  config = mkIf cfgBash.enable {
    programs.bash.shellAliases = cfg;
  };
  options.ms0503.bash.aliases = mkOption {
    description = "Bash aliases.";
    type = types.attrsOf types.str;
  };
}
