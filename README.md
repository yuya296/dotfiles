# dotfiles

Nix + Home Manager で CLI と dotfiles を管理する。GUI アプリと各言語のバージョン管理は Homebrew / 既存ツールのまま。

## 適用（macOS）

```sh
cd ~/dotfiles
home-manager switch --flake .#yuya-darwin
```

適用後は新しいターミナルを開く。

## 確認

```sh
nix flake check --no-build
```

## 更新

```sh
nix flake update
home-manager switch --flake .#yuya-darwin
```

## 戻す

```sh
home-manager generations
home-manager switch --rollback
```

Linux では `.#yuya-linux` を指定する。
