{pkgs, ...}: {
  imports = [
    ./bash
    ./development.nix
    ./direnv.nix
    ./git.nix
    ./neovim
    ./nix.nix
    ./tools.nix
  ];
}
