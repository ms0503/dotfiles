# ms0503's dotfiles

- [English](README.md)

Nix Flakeで管理している環境設定。

## 使い方

### 必要なもの

- Nix (下記のexperimental-featuresが必要)
  - `flakes`
  - `nix-command`
  - `pipe-operators`

### コマンド

```shell
# ブートストラップ環境の立ち上げ(初回OSセットアップ用)
nix --extra-experimental-features 'flakes nix-command pipe-operators' shell github:ms0503/dotfiles#bootstrap
# リポジトリのクローン
ghq get https://github.com/ms0503/dotfiles.git
cd "$(ghq root)/github.com/ms0503/dotfiles"
# ms0503/private-pkgs.nixの削除(ユーザー向け)
patch -p1 <remove-private-pkgs.patch
# 開発シェルの立ち上げ
nix --extra-experimental-features 'flakes nix-command pipe-operators' shell
# マシンディレクトリの作成(初回セットアップ用)
mkdir machines/MACHINE_NAME
# 設定のコピー(初回OSセットアップ用)
cp /etc/nixos/configuration.nix machines/MACHINE_NAME/nixos.nix
cp /etc/nixos/hardware-configuration.nix machines/MACHINE_NAME/
# home-manager設定の作成(初回セットアップ用)
vi machines/MACHINE_NAME/home-manager.nix
# モジュール設定のコピー・編集(初回セットアップ用)
cp machines/_skel/config-{hm,nixos}.nix machines/MACHINE_NAME/
vi machines/MACHINE_NAME/config-{hm,nixos}.nix
# マシンの登録
vi machines/default.nix
# OSの同期(NixOSのみ)
nh os switch .
# ホームの同期
nh home switch .
```

## 関連ページ

- [asa1984/dotfiles](https://github.com/asa1984/dotfiles) (~パクっ...~参考元)
