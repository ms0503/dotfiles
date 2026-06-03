{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.ms0503.shell.type = mkOption {
    description = "Login shell.";
    type = types.enum [
      "bash"
      "zsh"
    ];
  };
}
