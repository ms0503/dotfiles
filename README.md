ms0503's dotfiles
=====================

- [日本語](README.ja.md)

My configurations managed by home-manager.

# How to use
## Requirements
- Nix (with extra-experimental-features below)
 - `nix-command`
 - `flakes`

## Commands
```shell
$ # On first time
$ nix develop --command sync-home
$ # Otherwise
$ sync-home
```
