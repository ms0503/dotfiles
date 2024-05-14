{pkgs, ...}: {
  imports = [
    ./bash
    ./direnv.nix
    ./git.nix
    ./home-manager.nix
    ./neovim
    ./nix.nix
    ./tools.nix
  ];
}
