{pkgs, ...}: {
  imports = [
    ./starship.nix
  ];
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = import ./aliases.nix;
  };
}
