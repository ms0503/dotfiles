{pkgs, ...}: {
  imports = [
    ./bash
    ./development.nix
    ./direnv.nix
    ./git.nix
    ./home-manager.nix
    ./neovim
    ./nix.nix
    ./tools.nix
  ];
}
