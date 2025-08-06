# ms0503's dotfiles

- [English](README.md)

Nix flakesで管理している環境設定。

## 使い方

### 必要なもの

- Nix (下記のexperimental-featuresが必要)
  - `nix-command`
  - `flakes`
- `nh`

### コマンド

```shell
# ms0503/private-pkgs.nixの削除(ユーザー向け)
patch -p1 <remove-private-pkgs.patch
# OSの同期(NixOSのみ)
nh os switch .
# ホームの同期
nh home switch .
```

## 関連ページ

- [asa1984/dotfiles](https://github.com/asa1984/dotfiles) (~パクっ...~参考元)
