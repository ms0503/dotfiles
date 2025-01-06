# ms0503's dotfiles

- [日本語](README.ja.md)

My configurations managed by nix flakes.

## How to use

### Requirements

- Nix (with extra-experimental-features below)
  - `nix-command`
  - `flakes`
- `nh`

### Commands

```shell
# Remove ms0503/private-pkgs.nix, for user
patch -p1 <remove-private-pkgs.patch
# Sync OS (NixOS only)
nh os switch .
# Sync Home
nh home switch .
```

## Related pages

- [asa1984/dotfiles](https://github.com/asa1984/dotfiles) (base config)
