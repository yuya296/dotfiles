# rbenv init (interactive)
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# Lazy-load nvm (recommended)
export NVM_DIR="$HOME/.nvm"

# Expose a Node bin early for global CLIs (codex etc) without loading nvm
__nvm_prepend_default_bin() {
  local def ver

  # Read default alias
  if [[ -r "$NVM_DIR/alias/default" ]]; then
    def="$(<"$NVM_DIR/alias/default")"
  fi

  # If default resolves to a concrete version, use it
  if [[ -n "$def" && "$def" == v* && -d "$NVM_DIR/versions/node/$def/bin" ]]; then
    path=("$NVM_DIR/versions/node/$def/bin" $path)
    return 0
  fi

  # If default is "node"/"stable"/etc (not resolvable), fallback to latest installed v*
  ver="$(ls -1 "$NVM_DIR/versions/node" 2>/dev/null | grep '^v' | sort -V | tail -n 1)"
  if [[ -n "$ver" && -d "$NVM_DIR/versions/node/$ver/bin" ]]; then
    path=("$NVM_DIR/versions/node/$ver/bin" $path)
    return 0
  fi

  return 1
}
__nvm_prepend_default_bin
unset -f __nvm_prepend_default_bin

__load_nvm() {
  [[ -s "$NVM_DIR/nvm.sh" ]] || return 1
  source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
}

nvm()  { unfunction nvm node npm npx 2>/dev/null; __load_nvm; nvm  "$@"; }
node() { unfunction nvm node npm npx 2>/dev/null; __load_nvm; node "$@"; }
npm()  { unfunction nvm node npm npx 2>/dev/null; __load_nvm; npm  "$@"; }
npx()  { unfunction nvm node npm npx 2>/dev/null; __load_nvm; npx  "$@"; }
