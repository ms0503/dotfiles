# ms0503's dotfiles

- [English](README.md)

home-managerで管理している設定集。

# 使い方

## 要件

- Nix (下記のextra-experimental-feturesが有効であること)
- `nix-command`
- `flakes`

## コマンド

```shell
$ # 初回のみ
$ nix develop --command sync-home
$ # 以降
$ sync-home
```
