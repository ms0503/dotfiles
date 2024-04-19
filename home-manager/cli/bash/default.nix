{pkgs, ...}: {
  imports = [
    ./starship.nix
  ];
  programs.bash = {
    enable = true;
    enableCompletion = true;
    profileExtra = builtins.readFile ./.profile;
    shellAliases = import ./aliases.nix;
  };
}
