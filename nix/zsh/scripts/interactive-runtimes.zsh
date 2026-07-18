# Runtime managers and integrations maintained outside Nix.
[[ -r "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# Keep the default Node version available without paying nvm's startup cost.
export NVM_DIR="$HOME/.nvm"

__nvm_prepend_default_bin() {
  local default_version latest_version
  [[ -r "$NVM_DIR/alias/default" ]] && default_version="$(<"$NVM_DIR/alias/default")"

  if [[ "$default_version" == v* && -d "$NVM_DIR/versions/node/$default_version/bin" ]]; then
    path=("$NVM_DIR/versions/node/$default_version/bin" $path)
    return
  fi

  latest_version="$(command ls -1 "$NVM_DIR/versions/node" 2>/dev/null | command grep '^v' | command sort -V | command tail -n 1)"
  [[ -n "$latest_version" && -d "$NVM_DIR/versions/node/$latest_version/bin" ]] && \
    path=("$NVM_DIR/versions/node/$latest_version/bin" $path)
}
__nvm_prepend_default_bin
unset -f __nvm_prepend_default_bin

__load_nvm() {
  [[ -s "$NVM_DIR/nvm.sh" ]] || return 1
  source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
}

nvm()  { unfunction nvm node npm npx 2>/dev/null; __load_nvm; nvm "$@"; }
node() { unfunction nvm node npm npx 2>/dev/null; __load_nvm; node "$@"; }
npm()  { unfunction nvm node npm npx 2>/dev/null; __load_nvm; npm "$@"; }
npx()  { unfunction nvm node npm npx 2>/dev/null; __load_nvm; npx "$@"; }

if (( $+commands[rbenv] )); then
  eval "$(rbenv init -)"
fi

[[ -r "$HOME/.opam/opam-init/init.zsh" ]] && source "$HOME/.opam/opam-init/init.zsh" >/dev/null 2>&1

# Preserve the local wrapper while leaving the underlying Homebrew command available.
unalias brew 2>/dev/null
if [[ -x "$HOME/dev/brewfile/brew_with_commit.sh" ]]; then
  brew() { "$HOME/dev/brewfile/brew_with_commit.sh" "$@"; }
fi
