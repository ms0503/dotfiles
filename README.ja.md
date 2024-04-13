ms0503's nix dotfiles
=====================

- [English](README.md)

NixOS・home-managerの設定

# 概要
|   種別   |      名前       |                説明                 |
| :------: | :-------------: | :---------------------------------: |
|  シェル  | Bash + Starship |      強いしかっこいい(小並感)       |
| エディタ |     Neovim      |   他にいいエディタがあるとでも？    |

## NixOS
|     種別     |         名前          |     Description     |
| :----------: | :-------------------: | :-----------------: |
|   カーネル   | linuxPackages\_latest | 普通のLinuxカーネル |
| デスクトップ |   GNOME on Wayland    |  シンプルかつ強力   |
|     言語     |        日本語         | 我らが母国語である  |

# ディレクトリ
## `home-manager`
ユーザーレベルのプログラムたち
- `cli` - CLIツール
- `desktop` - デスクトップ環境
- `gui` - GUIアプリ

## `hosts`
ホスト毎の設定
- `mainpc` - メインデスクトップPC
- `tp-x280` - メインノートPC(ThinkPad X280)
- `test` - `mainpc`上のNixOSテスト用VM

## `modules`
NixOSのシステムワイドなプログラムたち
- `core` - コアのプログラムとか設定
- `desktop` - デスクトップで使う基本的なプログラム
- `programs` - 追加のプログラム

## `pkgs`
ローカルパッケージ

# 使い方
## 要件
- Nix (下記のextra-experimental-feturesが有効であること)
 - `nix-command`
 - `flakes`

## コマンド
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

# 参照
- [asa1984/dotfiles](https://github.com/asa1984/dotfiles) (基本的なファイル構造とREADME)
