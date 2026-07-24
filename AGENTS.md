# AGENTS.md

## Nix パッケージ追加

- `home.packages` に Nix パッケージを追加する前に、対象属性が使用する nixpkgs の `pkgs` または `unstable` に存在することを確認する。
- `nix eval` などで属性の存在を検証し、存在しないパッケージ名を設定に追加しない。
- 追加するライブラリやパッケージは原則 `pkgs` の stable 版を使う。stable に存在しない場合、または最新版が明示的に必要な場合だけ `unstable` を使う。
