# dotfiles

Nix + Home Manager で CLI と dotfiles を管理する。GUI アプリと各言語のバージョン管理は Homebrew / 既存ツールのまま。

## 適用（macOS）

```sh
cd ~/dotfiles
home-manager switch --flake .#darwin
```

適用後は新しいターミナルを開く。

端末固有の zsh 上書きは `~/.config/zsh/local.zsh` に置く（Git / Nix 管理外）。雛形は `nix/zsh/local.zsh.example`。

## 確認

```sh
nix flake check --no-build
```

## 更新

```sh
nix flake update
home-manager switch --flake .#darwin
```

## 戻す

```sh
home-manager generations
home-manager switch --rollback
```

Ubuntu では `.#ubuntu` を指定する。
