ms0503's nix dotfiles
=====================

- [日本語](README.ja.md)

NixOS & home-manager configurations

# Overview
|  Type  |      Name       |             Description             |
| :----: | :-------------: | :---------------------------------: |
| Shell  | Bash + Starship |           Powerful & Cool           |
| Editor |     Neovim      | Do you know any other good editors? |

## NixOS
|  Type   |         Name          |     Description     |
| :-----: | :-------------------: | :-----------------: |
| Kernel  | linuxPackages\_latest | Normal Linux Kernel |
| Desktop |   GNOME on Wayland    |   Simple & Mighty   |
|  Lang   |       Japanese        | My primary language |

# Directories
## `home-manager`
User-level programs
- `cli` - Command-line tools
- `desktop` - Desktop Environments
- `gui` - Common GUI applications

## `hosts`
Per-host settings
- `test` - NixOS test VM on my primary desktop PC

## `modules`
System-wide programs on NixOS
- `core` - Core programs & settings
- `desktop` - Basic programs on desktop environments
- `programs` - Additional programs

## `pkgs`
Local packages

# How to use
## Requirements
- Nix (with extra-experimental-features below)
 - `nix-command`
 - `flakes`

## Commands
### NixOS modules
```shell
$ nix develop
$ switch-nixos "<hostname>"
$ sudo reboot
```

### home-manager
```shell
$ nix develop
$ switch-home "<username>@<hostname>"
```

# Reference
- [asa1984/dotfiles](https://github.com/asa1984/dotfiles) (base structure & readme)
