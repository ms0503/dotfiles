# ms0503's dotfiles

- [日本語](README.ja.md)

My configurations managed by Nix Flake.

## How to use

### Requirements

- Nix (with extra-experimental-features below)
  - `flakes`
  - `nix-command`
  - `pipe-operators`

### Commands

```shell
# Enter bootstrap environment, for first OS setup
nix --extra-experimental-features 'flakes nix-command pipe-operators' shell github:ms0503/dotfiles#bootstrap
# Clone this repository
ghq get https://github.com/ms0503/dotfiles.git
# Remove ms0503/private-pkgs.nix, for user
patch -p1 <remove-private-pkgs.patch
# Enter devshell
nix --extra-experimental-features 'flakes nix-command pipe-operators' shell
# Create machine directory, for first setup
mkdir machines/MACHINE_NAME
# Copy configurations, for first OS setup
cp /etc/nixos/configuration.nix machines/MACHINE_NAME/nixos.nix
cp /etc/nixos/hardware-configuration.nix machines/MACHINE_NAME/
# Create home-manager configuration, for first setup
vi machines/MACHINE_NAME/home-manager.nix
# Copy and edit module configurations, for first setup
cp machines/_skel/config-{hm,nixos}.nix machines/MACHINE_NAME/
vi machines/MACHINE_NAME/config-{hm,nixos}.nix
# Register machine
vi machines/default.nix
# Sync OS (NixOS only)
nh os switch .
# Sync home
nh home switch .
```

## Related pages

- [asa1984/dotfiles](https://github.com/asa1984/dotfiles) (base config)
