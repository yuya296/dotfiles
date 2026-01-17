# rbenv init (interactive)
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# Lazy-load nvm (recommended)
export NVM_DIR="$HOME/.nvm"
__load_nvm() {
  [[ -s "$NVM_DIR/nvm.sh" ]] || return 1
  source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
}

nvm()  { unfunction nvm node npm npx 2>/dev/null; __load_nvm; nvm  "$@"; }
node() { unfunction nvm node npm npx 2>/dev/null; __load_nvm; node "$@"; }
npm()  { unfunction nvm node npm npx 2>/dev/null; __load_nvm; npm  "$@"; }
npx()  { unfunction nvm node npm npx 2>/dev/null; __load_nvm; npx  "$@"; }
